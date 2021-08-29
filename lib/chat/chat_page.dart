import 'dart:io';

import 'package:chat_app/chat/users_list.dart';
import 'package:chat_app/firebase/firebase_class.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/chat.dart';
import 'models/chat_users.dart';

class ChatPage extends StatefulWidget{
  static const String id = '/chat_page';
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, UsersList.id);
                  },
                    child: Text("Chats",
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade400,size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            FutureBuilder<List<ChatUsers>>(
              future: getChats(),
              builder: (context, snapshot) {
                List<ChatUsers> chatUsers = [];

                if (snapshot.hasData) {
                  chatUsers = snapshot.data as List<ChatUsers>;
                  // print(chatUsers.isNotEmpty);

                  return ListView.builder(
                    itemCount: chatUsers.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FutureBuilder<User>(
                        future: getUserData(chatUsers[index].senders.where((element)
                        => element
                            != FirebaseClass.getCurrentUserUid())
                            .first),
                        builder: (context, snapshot) {
                          User user;
                          if(snapshot.hasData) {
                            user = snapshot.data as User;
                            return ChatUsersList(
                            user: user,
                            chatMessages: chatUsers[index].chatMessage,

                          );
                          }
                          else return Center(
                              child:
                              // Text('No chats')
                              CircularProgressIndicator()
                          );

                        }
                      );
                    }
                );
                }
                else return Center(
                    child:
                    Text('No chats')

                  // CircularProgressIndicator()
                );
              }
            ),
          ],
        ),
      ),
    );
  }
  Future<User> getUserData(String userId) async =>
      // await Future.delayed(Duration(milliseconds: 100), () {
  await FirebaseClass().loadUserData(userUid: userId);


Future<List<ChatUsers>> getChats() async =>
    // await Future.delayed(Duration(milliseconds: 100), () {
await FirebaseClass().getChats();


}