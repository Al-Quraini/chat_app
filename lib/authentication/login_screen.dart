import 'package:chat_app/authentication/reset_page.dart';
import 'package:chat_app/chat/users_list.dart';
import 'package:chat_app/firebase/authentication_service.dart';
import 'package:chat_app/firebase/firestore_service.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? email;
  String? password;
  User? user;

  void loginUser() async{

    await AuthenticationService().loginUser(email!, password!,);

      loginSuccess();

    //BlocProvider.of<CounterCubit>(context).hideSpinner();


  }

  void loginSuccess() async{
    //user = await FirebaseFirestoreClass().loadUserData();
    //Navigator.popAndPushNamed(context, '/items_screen', arguments: user);
    await loadData();
    print('emaaaaaaaaaaaaaai ${user!.email}');

    // Navigator.popAndPushNamed(context, ItemsScreen.id);
    Navigator.pop(context);
  }

  Future<void> loadData() async{
    print('meeeeeeeeeeeeeeeeeeeeeeeeeeem1');
    this.user = (await FirestoreService().loadUserData(
        userUid: AuthenticationService.getCurrentUserUid()!
    ));

  }

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured'),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: (){
              Navigator.of(ctx).pop();
            },
          )
        ],
      )
    );
  }

  Future<void> _submit() async
  {


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Signup'),
                Icon(Icons.person_add)
              ],
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(SignupScreen.id);
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
                  Colors.lightGreenAccent,
                  Colors.blue,
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

                        //password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value)
                          {
                            if(value!.isEmpty || value.length<=5)
                              {
                                return 'invalid password';
                              }
                            return null;
                          },
                          onChanged: (value) => password =value,

                          /*  onSaved: (value)
                          {
                          },*/
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){
                              Navigator.of(context)
                                  .pushNamed(ResetPage.id);

                            }, child: Text('Forget Password'))
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text(
                            'Submit'
                          ),
                          onPressed: ()
                          async {
                            await AuthenticationService().loginUser(email!, password!);
                            Navigator.of(context).pushReplacementNamed(UsersList.id);
                          },
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
