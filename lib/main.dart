import 'package:chat_app/authentication/login_screen.dart';
import 'package:chat_app/authentication/reset_page.dart';
import 'package:chat_app/authentication/signup_screen.dart';
import 'package:chat_app/authentication/verification_page.dart';
import 'package:chat_app/chat/chat_detail_page.dart';
import 'package:chat_app/chat/chat_page.dart';
import 'package:chat_app/chat/users_list.dart';
import 'package:chat_app/firebase/firestore_service.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/pages/animation_page.dart';
import 'package:chat_app/pages/textfield_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase/authentication_service.dart';

//main page

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(AuthenticationService.getCurrentUserUid());
    return MaterialApp(
      title: 'Flutter Demo',
      // home: Container(),
        initialRoute: AuthenticationService.getCurrentUserUid() != null
             ?
        ( AuthenticationService.getCurrentUser()!.emailVerified ?
        UsersList.id  :
        UsersList.id )
            : LoginScreen.id,
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

            case AnimatedListSample.id  :
              return  MaterialPageRoute(builder: (_) =>
                  AnimatedListSample()
              );

            case VerificationPage.id  :
              return  MaterialPageRoute(builder: (_) =>
                  VerificationPage()
              );

            case ResetPage.id  :
              return  MaterialPageRoute(builder: (_) =>
                  ResetPage()
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

