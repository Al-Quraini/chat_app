import 'package:chat_app/firebase/authentication_service.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
  static const String id = 'ResetPage';
  const ResetPage({Key? key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
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
                onChanged: (value) => email =value,
                /*onSaved: (value)
                            {
                              _authData['email'] = value;
                            },*/
              ),
            ),

            ElevatedButton(

                style: ElevatedButton.styleFrom(
                    primary: Colors.purpleAccent,
                    fixedSize: Size(150, 50)
                ),
                onPressed: (){
                  AuthenticationService().resetPassword(email: email);
                  Navigator.pop(context);

                },
                child: Text(
                    'Reset Password'
                )
            ),
          ],
        ),
      ),
    );
  }
}
