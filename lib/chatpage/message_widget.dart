import 'package:chatapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../model/message.dart';

class MessageWidget extends StatelessWidget {

  Message message;
  MessageWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    return userProvider.user?.id==message.senderId ?
    SentMessage(message: message,):ReceivedMessage(message: message,);
  }
}
class SentMessage extends StatelessWidget {

  Message message;
  SentMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMicrosecondsSinceEpoch(message.senderTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight:Radius.circular(10) ,
              topLeft:Radius.circular(10) ,
              bottomLeft: Radius.circular(10),
            ),
            color: Colors.blueAccent
          ),
          child: Text(message.content,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),),

        ),

        Text('${date.hour}:${date.minute}:${date.second}'),

      ],
    );
  }
}
class ReceivedMessage extends StatelessWidget {
  Message message;
  ReceivedMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMicrosecondsSinceEpoch(message.senderTime);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message.senderName,
        style: TextStyle(fontWeight: FontWeight.bold,
        color: Colors.black),),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight:Radius.circular(10) ,
                topLeft:Radius.circular(10) ,
                bottomRight: Radius.circular(10),
              ),
              color: Colors.grey
          ),
          child: Text(message.content,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20
          ),),
        ),
    Text('${date.hour}:${date.minute}:${date.second}'),

      ],
    );
  }
}

