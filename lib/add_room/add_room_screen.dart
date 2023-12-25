import 'dart:async';
import 'package:chatapp/add_room/add_room_navigator.dart';
import 'package:chatapp/add_room/add_room_viewmodel.dart';
import 'package:chatapp/model/category.dart';
import 'package:chatapp/utils.dart' as Utils;
import 'package:flutter/material.dart';
import '../Home/home_screen.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'add room';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> implements AddRoomNavigator {
  String title = '';
  String description = '';
  var formkey = GlobalKey<FormState>();
  List<Category> categories = Category.getCategories();
  AddRoomViewModel viewmodel = AddRoomViewModel();
  Category? selecteditem = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Image.asset(
        'assets/images/background2.jpg',
        height: double.infinity,
        fit: BoxFit.fill,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Chat App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 22),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create New Room',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      'assets/images/group.png',
                      height: 150,
                      width: 200,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter room name';
                        } else
                          return null;
                      },
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter Room Name',
                          labelStyle: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButton<Category>(
                      value: selecteditem != null ? selecteditem : categories[0],
                      onChanged: (newCategory) {
                        if (newCategory != null) {
                          selecteditem = newCategory;
                          setState(() {});
                        }
                      },
                      items: categories
                          .map((category) => DropdownMenuItem<Category>(
                              value: category,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    category.title,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Image.asset(category.image),
                                ],
                              )))
                          .toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter room description';
                        } else
                          return null;
                      },
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter Room Description',
                          labelStyle: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(onPressed: () {
                       submitForm();
                    },
                        child: Text('Add Room'))
                  ],
                ),
              ),
            ),
          ))
    ]);
  }
  void submitForm() {
    if(formkey.currentState?.validate() == true){
      viewmodel.AddRoom(title, description, selecteditem!.id);

    }
  }

  @override
  void hideloading() {
    Utils.hideloading(context);
  }

  @override
  void navigateToHome() {
    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  @override
  void showloading() {
    Utils.showloading(context, 'loading');
  }

  @override
  void showmessage(String message) {
    Utils.showmessage(context, message,
        'ok', (context){
          Navigator.pop(context);
        }
    );
  }
}


