import 'package:chat_app/authentication/login_screen.dart';
import 'package:chat_app/authentication/signup_screen.dart';
import 'package:chat_app/chat/chat_detail_page.dart';
import 'package:chat_app/chat/chat_page.dart';
import 'package:chat_app/chat/users_list.dart';
import 'package:chat_app/firebase/firebase_class.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/pages/animation_page.dart';
import 'package:chat_app/pages/textfield_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//main page

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(FirebaseClass.getCurrentUserUid());
    return MaterialApp(
      title: 'Flutter Demo',
      // home: Container(),
        initialRoute: FirebaseClass.getCurrentUserUid() != null ?
        UsersList.id : LoginScreen.id,
        onGenerateRoute: (settings) {
          // Routes
          switch (settings.name) {



            case LoginScreen.id :
              return  MaterialPageRoute(builder: (context) =>
                  LoginScreen());


             case SignupScreen.id :
                        return  MaterialPageRoute(builder: (context) =>
                            SignupScreen());

            case ChatPage.id  :
              return  MaterialPageRoute(builder: (_) =>
                  ChatPage()
              );

           case UsersList.id  :
                        return  MaterialPageRoute(builder: (_) =>
                            UsersList()
                        );

            case AnimationPage.id  :
              return  MaterialPageRoute(builder: (_) =>
                  AnimationPage()
              );

            case TextFieldPage.id  :
              return  MaterialPageRoute(builder: (_) =>
                  TextFieldPage()
              );


            case ChatDetailPage.id  :
              final User arg = settings.arguments as User;
              return  MaterialPageRoute(builder: (_) =>
                  ChatDetailPage(argument: arg,)
              );


            default : return null;

          }

        }
    );
  }
}

