import 'package:chat_app/chat/users_list.dart';
import 'package:chat_app/firebase/authentication_service.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  static const String id = '/VerificationPage';
  const VerificationPage({Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  @override
  void initState() {
    AuthenticationService.getCurrentUser()!.sendEmailVerification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(

                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    fixedSize: Size(150, 50)
                ),
                onPressed: (){
                  checkEmailVerified();
                },
                child: Text(
                    'Verify email'
                )
            ),

            ElevatedButton(

                style: ElevatedButton.styleFrom(
                    primary: Colors.purpleAccent,
                    fixedSize: Size(150, 50)
                ),
                onPressed: (){
                  AuthenticationService.getCurrentUser();

                },
                child: Text(
                    'Verify phone'
                )
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    final user = AuthenticationService.getCurrentUser();
    await user!.reload();
    if (user.emailVerified) {
      Navigator.pushReplacementNamed(context, UsersList.id);
    }
  }
}
