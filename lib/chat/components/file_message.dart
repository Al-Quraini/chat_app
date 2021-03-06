import 'package:chat_app/chat/models/chat_message.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';


class FileMessage extends StatelessWidget {
  final ChatMessage chatMessage;

  const FileMessage({Key? key,required this.chatMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7, // 45% of total width
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Text(
            '🗂 ${chatMessage.message}'
          ),
          decoration: BoxDecoration(
            color: Colors.black12,

            /*image: DecorationImage(
                fit: BoxFit.cover,
                //fit: BoxFit.fill,
                image: chatMessage.message.isEmpty ?
                AssetImage("assets/images/place_holder.jpg") :
                NetworkImage(chatMessage.message)
            ),*/
            //color: product.color,
            //borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
