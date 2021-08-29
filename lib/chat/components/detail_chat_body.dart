import 'package:bubble/bubble.dart';
import 'package:chat_app/chat/models/chat_message.dart';
import 'package:chat_app/firebase/firebase_class.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//update file

import 'package:timeago/timeago.dart' as timeago;

import 'chat_bubble.dart';
import 'chat_input_field.dart';

class Body extends StatefulWidget {
  final User user;

  const Body({Key? key, required this.user}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool checkIfLast({required ChatMessage nextBubble,required ChatMessage prevBubble}) {
    if (checkIfSameSender(nextBubble: nextBubble, prevBubble: prevBubble) ||
        (isNotSamePeriod(nextBubble: nextBubble, prevBubble: prevBubble) &&
            DateTime.now().difference(nextBubble.dateTime).inDays < 2) ||
        isFirstBubbleInDay(nextBubble: nextBubble, prevBubble: prevBubble))
      return true;
    return false;
  }

  bool checkIfSameSender({required ChatMessage nextBubble,required ChatMessage prevBubble}) =>
      nextBubble.type != prevBubble.type;

  bool isNotSamePeriod({required ChatMessage nextBubble,required ChatMessage prevBubble}) =>
      (nextBubble.dateTime.millisecondsSinceEpoch -
          prevBubble.dateTime.millisecondsSinceEpoch) >
      Duration(minutes: 10).inMilliseconds;

  bool isToday(DateTime dateTime) {
    bool inSameDay = ((DateTime.now().day - dateTime.day) == 0 &&
        (DateTime.now().month - dateTime.month) == 0 &&
        (DateTime.now().year - dateTime.year) == 0);
    return inSameDay;
  }

  bool isFirstBubbleInDay({required ChatMessage nextBubble,required ChatMessage prevBubble}) {
    var prevDate = prevBubble.dateTime;
    var nextDate = nextBubble.dateTime;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final String d1 = formatter.format(prevDate);
    final String d2 = formatter.format(nextDate);

    return d1 != d2;
  }

  String dateFormatter(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    final String todayDate = formatter.format(DateTime.now());
    if (formattedDate == todayDate)
      return 'TODAY';
    else if ((DateTime.now().day - date.day) == 1 &&
        (DateTime.now().month - date.month) == 0 &&
        (DateTime.now().year - date.year) == 0)
      return 'YESTERDAY';
    else if (DateTime.now().difference(date).inDays < 7)
      return '${dayOfWeek(date)}, ${formatTime(date)}';
    else {
      // print(
      //     'num of days is flkdnflksdfn ${DateTime.now().difference(date).inDays}');
      return '${dayOfWeek(date)}, ${DateFormat("MMMM d").format(date)}';
    }
  }

  String dayOfWeek(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "Monday";
    }
  }

  String formatTime(DateTime dateTime) {
    final formattedStr = DateFormat.jm().format(dateTime);

    return formattedStr;
  }

  @override
  void initState() {
    FirebaseClass().readMessage(user: widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseClass().messagesStream(uid: widget.user.uid),
              builder: (context, snapshot) {
                FirebaseClass().readMessage(user: widget.user);
                List<ChatMessage> chatMessages = [];
                if (snapshot.hasData) {
                  chatMessages = FirebaseClass().getMessages(snapshot);
                }
                return SingleChildScrollView(
                  reverse: true,
                  child: ListView.builder(
                    // reverse: true,
                    itemCount: chatMessages.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (dateBubble(chatMessages, index) != null)
                            dateBubble(chatMessages, index),
                          chatBubble(chatMessages, index),
                          if (chatMessages.isNotEmpty &&
                                  (index + 1) == chatMessages.length
                              ? false
                              : isNotSamePeriod(
                                      prevBubble: chatMessages[index],
                                      nextBubble: chatMessages[index + 1]) &&
                                  isToday(chatMessages[index].dateTime))
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                // child: Text(timeago.format(chatMessages[index].dateTime)
                                child: Text(
                                    '${formatTime(chatMessages[index + 1].dateTime)}')),
                          if (chatMessages[index].isRead &&
                              index == chatMessages.length - 1 &&
                              chatMessages[index].sentBy ==
                                  FirebaseClass.getCurrentUserUid())
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Align(
                                alignment: chatMessages[index].type ==
                                        MessageFrom.Sender
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                child: Text('seen'),
                              ),
                            )
                        ],
                      );
                    },
                  ),
                );
              }),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: ChatInputField(
              user: widget.user,
            ))
      ],
    );
  }

  ChatBubble chatBubble(List<ChatMessage> chatMessages, int index) {
    return ChatBubble(
      messageType:
          chatMessages[index].sentBy == FirebaseClass.getCurrentUserUid()
              ? MessageFrom.Sender
              : MessageFrom.Receiver,
      chatMessages: chatMessages[index],
      lastInGroup: chatMessages.isNotEmpty && (index + 1) == chatMessages.length
          ? true
          : checkIfLast(
              prevBubble: chatMessages[index],
              nextBubble: chatMessages[index + 1]),
    );
  }

  Widget dateBubble(List<ChatMessage> chatMessages, int index) {
    if (index == 0
        ? true
        : isFirstBubbleInDay(
            prevBubble: chatMessages[index - 1],
            nextBubble: chatMessages[index])) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Bubble(
          margin: BubbleEdges.only(top: 10),
          alignment: Alignment.center,
          nip: BubbleNip.no,
          color: Color.fromRGBO(212, 234, 244, 1.0),
          child: Text(dateFormatter(chatMessages[index].dateTime),
              textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
        ),
      );
    }

    return Container();
  }
}
