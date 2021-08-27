import 'package:flutter/cupertino.dart';

import 'chat_message.dart';


class ChatUsers{
  final String chatId;
  final List<ChatMessage> chatMessage;
  final List<dynamic> senders;
  ChatUsers({
    required this.chatMessage, required this.senders, required this.chatId});
}