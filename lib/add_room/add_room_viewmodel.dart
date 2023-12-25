import 'package:chatapp/Database/Database_utils.dart';
import 'package:chatapp/add_room/add_room_navigator.dart';
import 'package:chatapp/model/Room.dart';
import 'package:flutter/widgets.dart';

class AddRoomViewModel extends ChangeNotifier{
  late AddRoomNavigator navigator;
  void AddRoom(String title, String description, String categoryId) async{
    Room room = Room(
        id: '', title: title, description: description, categoryid: categoryId);
    try{
      navigator.showloading();
      var createdRoom=await DatabaseUtils.AddRoom(room);
      navigator.hideloading();
      navigator.showmessage('Room created successfully');
      navigator.navigateToHome();
    }
    catch (e){
        navigator.hideloading();
        navigator.showmessage('something went wrong');
    }

  }
}
