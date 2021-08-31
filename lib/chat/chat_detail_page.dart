import 'package:chat_app/firebase/firestore_service.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/chat_detail_page_appbar.dart';
import 'components/chat_bubble.dart';
import 'components/detail_chat_body.dart';
import 'models/chat_message.dart';



class ChatDetailPage extends StatefulWidget{
  static const String id ='/ChatDetailPage';
  final User argument;

  const ChatDetailPage({Key? key,required this.argument}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {


  @override
  void initState() {
    // print(widget.argument.uid == FirebaseClass.getCurrentUserUid());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(user : widget.argument),
      body: Body(user: widget.argument,)
    );
  }
}




