import 'package:chatapp/chatpage/chat_screen.dart';
import 'package:flutter/material.dart';

import '../model/Room.dart';

class RoomWidget extends StatelessWidget {

  Room room;
  RoomWidget({required this.room});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ChatScreen.routeName,arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
        BoxShadow(

          blurRadius: 10.0,
          spreadRadius: 2.0,
        ), //BoxShadow
          ]),
          child:Column(
            children: [
              Image.asset('assets/images/${room.categoryid}.png',
              height: 100,
              width: 100,),
              SizedBox(height: 10,),
              Text(room.title),
            ],
          )
        ),
    );
  }
}
