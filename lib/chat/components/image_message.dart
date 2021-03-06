import 'package:chat_app/chat/models/chat_message.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';


class ImageMessage extends StatelessWidget {
  final ChatMessage chatMessage;

  const ImageMessage({Key? key,required this.chatMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding),

          decoration: BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
                fit: BoxFit.cover,
                //fit: BoxFit.fill,
                image:
                // chatMessage.url.isEmpty ?
                // AssetImage("assets/images/place_holder.jpg") :
                NetworkImage(chatMessage.url!)
            ),
            //color: product.color,
            //borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
