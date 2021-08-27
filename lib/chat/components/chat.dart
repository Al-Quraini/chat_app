import 'package:chat_app/chat/models/chat_message.dart';
import 'package:chat_app/firebase/firebase_class.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/utils/enums.dart';
import 'package:flutter/material.dart';

import '../chat_detail_page.dart';


class ChatUsersList extends StatefulWidget{
  final User user;
  final List<ChatMessage> chatMessages;
  ChatUsersList({
    required this.user,required this.chatMessages});
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ChatDetailPage.id, arguments: widget.user);
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: FadeInImage.assetNetwork(
                        placeholder: '/assets/images/place_holder.jpg',
                        image:widget.user.imageUrl
                        ).image,
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.user.name),
                          SizedBox(height: 6,),
                          Text( messageText(),style: TextStyle(fontSize: 14,color: Colors.grey.shade500),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.chatMessages.last.dateTime.toString(),style:
            TextStyle(fontSize: 12,color:
            widget.chatMessages.last.isRead && widget.chatMessages.last.sentBy
                == FirebaseClass.currentUser.uid?
            Colors.pink:Colors.grey.shade500),),
          ],
        ),
      ),
    );
  }

  String messageText(){
    switch(widget.chatMessages.last.chatMessageType){
    case ChatMessageType.text :
      return widget.chatMessages.last.message!;
      break;

      case ChatMessageType.image :
      return 'image 🌄';
      break;

      case ChatMessageType.audio :
          return 'voice message 🎤';
          break;

      case ChatMessageType.file:
        return 'file 🗂';
        break;
      default:
        return '';
    }
/*   if (widget.chatMessages.last.chatMessageType == ChatMessageType.text)
    return widget.chatMessages.last.message;

  else if (widget.chatMessages.last.chatMessageType == ChatMessageType.image)
    return 'image 🌄';

  else
    return 'voice message 🎤';*/

  }
}