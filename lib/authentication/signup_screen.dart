import 'package:chat_app/authentication/verification_page.dart';
import 'package:chat_app/chat/chat_page.dart';
import 'package:chat_app/chat/users_list.dart';
import 'package:chat_app/firebase/authentication_service.dart';
import 'package:chat_app/firebase/firestore_service.dart';
import 'package:chat_app/models/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const String id = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController _passwordController = new TextEditingController();

  Map<String, String> _authData = {
    'email' : '',
    'password' : ''
  };
  late String name;
  late String email;
  late String password;
  String phone ='331342';
  String location='somewhere';

  u.User? userData;



  void registerUser() async{

    String? imageUrl;
    final user =await AuthenticationService()
        .createNewUser(email, password);

    print('dskgnsdjlkgnsdlgndsfjlgnsadjlgnjlsdfnjl');


      userData = u.User(
        uid: AuthenticationService.getCurrentUserUid()!,
        name : name,
        email : email,
        imageUrl : imageUrl,
        phoneNumber : phone,
        location : location,
      );

      await FirestoreService().addUser(
          userData!,
              () async {
            await user!.user!.reload();


            if(user.user!.emailVerified)
                Navigator.of(context).pushReplacementNamed(UsersList.id);

            else
              Navigator.of(context).pushReplacementNamed(VerificationPage.id);
          }
      );





  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),

        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Login'),
                Icon(Icons.person)
              ],
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen.id);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.limeAccent,
                      Colors.redAccent,
                    ]
                )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //email
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'invalid name';
                            }
                            return null;
                          },
                        onChanged: (value) => name = value,
                        ),

                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value!.isEmpty || !value.contains('@'))
                            {
                              return 'invalid email';
                            }
                            return null;
                          },
                          onChanged: (value) => email = value,

                        ),

                        //password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value)
                          {
                            if(value!.isEmpty || value.length<=5)
                            {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onChanged: (value) => password = value,

                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text(
                              'Submit'
                          ),
                          onPressed: registerUser,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
