import 'package:chat_app/chat/models/chat_message.dart';
import 'package:chat_app/chat/models/chat_users.dart';
import 'package:chat_app/models/user.dart' as u;
import 'package:chat_app/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class FirebaseClass {
  static final FirebaseAuth _auth= FirebaseAuth.instance;
  static u.User? _user;
  final _firestore = FirebaseFirestore.instance;




  static u.User get currentUser => _user!;

  Future<void> _setLoggedInUser() async{
    _user =await
    loadUserData(userUid: getCurrentUserUid()!);

  }
  Future<u.User> loadUserData({String userUid = ''}) async {
    u.User? user;
    try {
      await _firestore
          .collection('users')
          .doc(userUid)
          .get().then((DocumentSnapshot snapshot) async {
        //print('sanpppppppp shoooooot ${snapshot.data()['phoneNumber']}');
        user = u.User(

          name : snapshot['name'],
          email :snapshot['email'],
          imageUrl: snapshot['imageUrl'],
          phoneNumber : snapshot['phoneNumber'],
          location :snapshot['location'],
          uid :snapshot.id,
        );
      })
          .then((value) {

          })
          .catchError((onError) {
          });

      return user!;
    } catch (e) {
      // print(e);
      return u.User(name: 'name', email: 'email', imageUrl: 'imageUrl',
          phoneNumber: 'phoneNumber', location: 'location', uid: 'uid');
      // return null;
    }
  }

  Future<List<u.User>> getUsers() async {
    List<u.User> users = [];
    try {
      await _firestore
          .collection('users')
          .get().then((QuerySnapshot snapshots) async {

        for(QueryDocumentSnapshot snapshot in snapshots.docs) {
          if (snapshot.id == getCurrentUserUid()!)
            continue;

              final user = u.User(
                name: snapshot['name'] ?? "",
                email: snapshot['email'] ?? "",
                imageUrl: snapshot['imageUrl'] ?? "",
                phoneNumber: snapshot['phoneNumber'] ?? "",
                location: snapshot['location'] ?? "",
                uid: snapshot.id,
              );

              users.add(user);
              // print('sanpppppppp shoooooot ${users.length}');

        }
          }).then((value) {
            // print('data loaded successfully');
          })
          .catchError((onError) => print(onError));

      return users;
    } catch (e) {
      // print(e);
      return [];
      // return null;
    }
  }

  Future<UserCredential?> loginUser(String email,
      String password,) async{
    try{
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    }catch(e){
      // print(e);
      return null;
    }
  }

  Future<bool> sendMessage({required u.User messageTo, required ChatMessage message}) async {
    try {
      DocumentReference documentReference = _firestore
          .collection('chats')
          .doc(generateChatUid(messageTo.uid, message.sentBy));

      await documentReference
          .set({
        'contacts': [getCurrentUserUid(),messageTo.uid],
      }).then((value) {
        documentReference.collection('messages')
            .doc()
            .set({
          'text' : message.message,
          'timeStamp' : message.dateTime,
          'sentBy' : message.sentBy,
          'url' : message.url,
          'isRead' : false,
          'messageType': EnumToString.convertToString(message.chatMessageType)
          // 'type' : message.type
        })
            .then((value) {
          // print('Data sent successfully');
          return true;
        })
            .catchError((error) {
          // print("Failed to add item: $error");
          return false;
        });
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserCredential?> createNewUser(String email, String password) async{
    try{
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return newUser;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<void> addUser(u.User user, Function callback) async {
    // Call the user's CollectionReference to add a new user
    try {
      await _firestore
          .collection('users')
          .doc(getCurrentUserUid())
          .set({
        'name': user.name, // John Doe
        'email': user.email, // Stokes and Sons
        'phoneNumber': user.phoneNumber, // Stokes and Sons
        'imageUrl': user.imageUrl,
        'location': user.location,
      })
          .then((value) {
            // print('Data sen successfully');
          })
          .catchError((error) => print("Failed to add user: $error"));
      callback();

    } catch (e) {
      print(e);
    }
  }

  Future<bool> readMessage({required u.User user}) async{
    // print('messageIds_________------- ${user.email}');

    List<String> messageIds=[];
    try {
      await _firestore
          .collection('chats')
          .doc(generateChatUid(user.uid,
          getCurrentUserUid()!)).collection('messages')
          .where('sentBy', isNotEqualTo: getCurrentUserUid())
          .get().then((QuerySnapshot snapshots) async {
            // print(snapshots.docs.length);
        for(var snapshot in snapshots.docs){
          messageIds.add(snapshot.id);
        }
        await markRead(messageIds, user);
        // print(messageIds);
        // print('messageIds_________-------');
      })

          .then((value) {
        // print('Data sent by reading successfully');
        return true;
      })
          .catchError((error) {
        print("Failed to add item: $error");
        return false;
      });


      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> messagesStream({required String uid}){
    return  _firestore.collection('chats')
        .doc(
        generateChatUid(getCurrentUserUid()!, uid))
        .collection('messages').orderBy('timeStamp')
        .snapshots();
  }

  List<ChatMessage> getMessages(AsyncSnapshot<QuerySnapshot> snapshots) {
    List<ChatMessage> messages =[];
    try {


      ChatMessage chatMessage;
      for (QueryDocumentSnapshot snapshot in snapshots.data!.docs) {
        var data = snapshot;
        Timestamp timeStamp =data['timeStamp'];

        chatMessage = ChatMessage(
          message: data['text'],
          type: data['sentBy'] == getCurrentUserUid() ?
          MessageFrom.Sender :
          MessageFrom.Receiver,
          url: data['url'],
          dateTime: timeStamp.toDate(),
          sentBy: data['sentBy'],
          isRead: data['isRead'],
          chatMessageType: EnumToString.fromString(ChatMessageType.values,
              data['messageType'])!,
        );
        messages.add(chatMessage);
      }



      return messages;

    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> markRead(List<String> mIds, user) async{
    try{
      for(String mId in mIds){
        await _firestore
            .collection('chats')
            .doc(generateChatUid(user.uid,
            getCurrentUserUid()!))
            .collection('messages').doc(mId)
            .update({
          'isRead' : true
        }
        );
      }
    } catch (e){

    }
  }

  Future<List<ChatUsers>> getChats() async{
    List<ChatUsers> chatUsers =[];
    try {
      await _firestore.collection('chats').get()
          .then((QuerySnapshot snapshots) async{
        ChatUsers chatUser;
        for (QueryDocumentSnapshot snapshot in snapshots.docs) {
          var data = snapshot;
          // Timestamp timeStamp =data['timeStamp'];

          chatUser = ChatUsers(
              chatId: snapshot.id,
              senders: data['contacts'],

              chatMessage: await getMessageList(data['contacts'].where((element)
              => element
                  != getCurrentUserUid())
                  .first)

          );
          if(chatUser.senders.contains(currentUser.uid))
            chatUsers.add(chatUser);

          print(chatUsers.length);
        }
        // print('mamamamamamamamamama ${chatUsers[0].chatMessage.length}');

        return chatUsers;


      });

      return chatUsers;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ChatMessage>> getMessageList(String uid) async {
    List<ChatMessage> messages =[];
    try {
      await _firestore.collection('chats')
          .doc(
          generateChatUid(getCurrentUserUid()!, uid))
          .collection('messages').orderBy('timeStamp').get()
          .then((QuerySnapshot snapshots) {
        ChatMessage chatMessage;
        for (QueryDocumentSnapshot snapshot in snapshots.docs) {
          var data = snapshot;
          Timestamp timeStamp =data['timeStamp'];

          chatMessage = ChatMessage(
            message: data['text'],
            type: data['sentBy'] == getCurrentUserUid() ?
            MessageFrom.Sender :
            MessageFrom.Receiver,
            isRead: data['isRead'],
            dateTime: timeStamp.toDate(),
            sentBy: data['sentBy'],
            chatMessageType: EnumToString.fromString(ChatMessageType.values,
                data['messageType'])!,
          );
          messages.add(chatMessage);
        }
      });




      return messages;

    } catch (e) {
      print(e);
      return [];
    }
  }

  String generateChatUid( String id1,  String id2){
    List<int> maxArr= [];

    List<int> uid1 = id1.codeUnits;
    List<int> uid2 = id2.codeUnits;

    for(int i =0; i< uid1.length && i<uid2.length ; i++){
      if(uid1[i] > uid2[i]){
        maxArr.add(uid1[i]);
      }
      else if( uid1[i] < uid2[i]){
        maxArr.add(uid2[i]);
      }
    }
    return String.fromCharCodes(maxArr);
  }
  static String? getCurrentUserUid(){
    if (_auth.currentUser == null) {
      return null;
    }

      return _auth.currentUser!.uid;

  }

  static logoutUser() => _auth.signOut();


}