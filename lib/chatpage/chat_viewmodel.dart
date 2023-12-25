import 'package:chatapp/Database/Database_utils.dart';
import 'package:chatapp/chatpage/chat_navigator.dart';
import 'package:chatapp/model/message.dart';
import 'package:chatapp/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Room.dart';

class ChatViewModel extends ChangeNotifier{
  late ChatNavigator navigator;
  late Room room;
  late MyUser currentUser;
  late Stream<QuerySnapshot<Message>> streamMessages;
  void sendMessage(String content){
    Message message=Message(
        id: '',
        roomId: room.id,
        senderId: currentUser.id,
        senderName: currentUser.Username,
        content: content,
        senderTime: DateTime.now().millisecondsSinceEpoch);
    try{
      DatabaseUtils.sendMessage(message);
      navigator.clearmessage();
    }
    catch (e){
      navigator.showmessage(e.toString());
    }
  }
  void loadMessages(){
    streamMessages=DatabaseUtils.loadMessages(room.id);
  }
}