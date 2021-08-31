import 'package:chat_app/authentication/login_screen.dart';
import 'package:chat_app/firebase/authentication_service.dart';
import 'package:chat_app/firebase/firestore_service.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/pages/animation_page.dart';
import 'package:chat_app/pages/textfield_page.dart';
import 'package:flutter/material.dart';
import 'chat_detail_page.dart';
import 'components/user_list.dart';

class UsersList extends StatelessWidget {
  static const String id = '/users_list';

  const UsersList({Key? key}) : super(key: key);

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chats",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    TextButton(onPressed: (){
                      AuthenticationService.logoutUser();
                      Navigator.of(context).pushReplacementNamed(LoginScreen.id);
                    }, child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ))
                  ],
                ),
              ),
            ),

            Row(
              children: [
                    ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        fixedSize: Size(150, 50)
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AnimatedListSample()),
                      );
                    },
                    child: Text(
                        'Animation'
                    )
                    ),

                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                        fixedSize: Size(150, 50)
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TextFieldPage()),
                      );
                    },
                    child: Text(
                        'Text Fields'
                    )),
                  ],
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
            FutureBuilder<List<User>>(
                future: getUsers(),
                builder: (context, snapshot) {
                  List<User> users = [];

                  if (snapshot.hasData) {
                    users = snapshot.data as List<User>;
                    // print(users.isNotEmpty);

                    return ListView.builder(
                        itemCount: users.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 16),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              if(users[index].uid != AuthenticationService.getCurrentUserUid()) {

                                // print((users[index].uid == FirebaseClass.getCurrentUserUid()));

                                Navigator.pushNamed(context,
                                    ChatDetailPage.id,
                                    arguments: users[index]);
                              }
                            },
                            child: UserList(
                              user: users[index],

                            ),
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

  Future<List<User>> getUsers() async =>
      // await Future.delayed(Duration(milliseconds: 100), () {
  await FirestoreService().getUsers();
}
