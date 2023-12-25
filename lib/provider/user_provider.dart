import 'package:chatapp/Database/Database_utils.dart';
import 'package:chatapp/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user;
  User? firebaseUser;

  UserProvider(){
    firebaseUser= FirebaseAuth.instance.currentUser;
    initUser();
  }

  initUser() async {
    if (firebaseUser!=null){
      user= await DatabaseUtils.getUser(firebaseUser?.uid ?? '');
    }
  }
}