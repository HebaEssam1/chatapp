import 'package:chatapp/Database/Database_utils.dart';
import 'package:chatapp/Home/Home_navigator.dart';
import 'package:chatapp/Home/Home_viewmodel.dart';
import 'package:chatapp/add_room/add_room_screen.dart';
import 'package:chatapp/add_room/room_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Room.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName='home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator {
  HomeViewModel viewModel=HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
          children:[
            Container(
              color: Colors.white,
            ),
            Image.asset('assets/images/background2.jpg',
              height: double.infinity,
              fit: BoxFit.fill,),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'Home',
                  style: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             floatingActionButton: FloatingActionButton(
               onPressed: (){
                 Navigator.of(context).pushNamed(AddRoomScreen.routeName);
               },
               child: Icon(Icons.add),
             ),
                body:StreamBuilder<QuerySnapshot<Room>>(
                  stream: DatabaseUtils.getRomms(),
                  builder:(context, asyncSnapshot) {
                    if(asyncSnapshot.connectionState==ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    else if(asyncSnapshot.hasError){
                      return Text(asyncSnapshot.error.toString());
                    }
                    else{
                      var roomsList=asyncSnapshot.data?.docs.map((e) => e.data()).toList();
                      return GridView.builder(
                        itemBuilder: (context, index) {
                          return RoomWidget(room: roomsList![index]);
                        },
                      itemCount: roomsList?.length,
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),);
                    }
                  },
                )

              ),
          ]

      ),
    );
  }
}
