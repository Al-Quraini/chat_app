import 'package:chat_app/firebase/firestore_service.dart';
import 'package:flutter/material.dart';

const Color primary = Color(0xff6635cb);
const Color primaryColor = Color(0xff2e1269);
const Color editTextBackground = Color(0xfff1f1f1);

class TextFieldPage extends StatefulWidget {
  static const String id = '/text_field_page';
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  String text1 = "";
  String text2 = "";
  String text3 = "";
  String text4 = "";

  final GlobalKey<FormState> _formKey3 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // text 1
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      text1 = value;
                    },

                    validator: (value) {
                      if (value == null && value!.isEmpty) {
                        print('nooooooo');
                        return 'This field is Required';
                      }
                    },

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: primary, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),


                      hintText: 'Text 1',
                      hintStyle: TextStyle(
                          color:
                          primaryColor
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                      fillColor: editTextBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      text2 = value;
                    },

                    validator: (value) {
                      if (value == null && value!.isEmpty) {
                        print('nooooooo');
                        return 'This field is Required';
                      }
                    },

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: primary, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),


                      hintText: 'Text 2',
                      hintStyle: TextStyle(
                          color:
                          primaryColor
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                      fillColor: editTextBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      text3 = value;
                    },

                    validator: (value) {
                      if (value == null && value!.isEmpty) {
                        print('nooooooo');
                        return 'This field is Required';
                      }
                    },

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: primary, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),


                      hintText: 'Text 3',
                      hintStyle: TextStyle(
                          color:
                          primaryColor
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                      fillColor: editTextBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      text4 = value;
                    },

                    validator: (value) {
                      if (value == null && value!.isEmpty) {
                        print('nooooooo');
                        return 'This field is Required';
                      }
                    },

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: primary, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),


                      hintText: 'Text 4',
                      hintStyle: TextStyle(
                          color:
                          primaryColor
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                      fillColor: editTextBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(

              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  fixedSize: Size(150, 50)
              ),
              onPressed: (){
                print('$text1 $text2 $text3');

                Map<String, String> map = {
                  'text1' : text1,
                  'text2' : text2,
                  'text3' : text3,
                  'text4' : text4,

                };

                FirestoreService().addTexts(map);
              },
              child: Text(
                  'Save',
                style: TextStyle(
                  color: Colors.black
                ),
              )),

        ],
      ),
    );
  }

  }

