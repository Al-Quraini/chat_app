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
            child: TextFormField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value){
                print('onChanged : $value');

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
          Padding(
            padding: EdgeInsets.all(12),
            child: TextFormField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onEditingComplete: (){
                print('onEditingComplete');

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
          Padding(
            padding: EdgeInsets.all(12),
            child: TextFormField(
              key: _formKey3,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onSaved: (value){
                print('onSaved : $value');
                debugPrint("on save event");
                print(value);
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
          Padding(
            padding: EdgeInsets.all(12),

            child: TextFormField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (value){
                print('onFieldSubmitted');
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

          Padding(
            padding: EdgeInsets.all(12),

            child: TextField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onSubmitted: (value){
                print('onSubmitted $value');
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: primary, width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),


                hintText: 'Text 5',
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

          ElevatedButton(

              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  fixedSize: Size(150, 50)
              ),
              onPressed: (){
                // if (_formKey3.currentState == null && !_formKey3.currentState!.validate()) {
                //   return;
                // }

                _onFormSaved();
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

  void _onFormSaved() {
    if (_formKey3.currentState == null) {
      print("_formKey.currentState is null!");
    } else if (_formKey3.currentState!.validate()) {
      print("Form input is valid");
    }
    }
  }

