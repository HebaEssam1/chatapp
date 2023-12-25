import 'package:chatapp/Database/Database_utils.dart';
import 'package:chatapp/Register/register_navigator.dart';
import 'package:chatapp/firebase_errors.dart';
import 'package:chatapp/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class RegisterViewModel extends ChangeNotifier{
  late RegisterNavigator navigator;
  Future<void> regsiterFiresbaseauth (String email,String password,String firstname,String lastname,String Username) async {
    try {
      navigator.showloading();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator.hideloading();
      navigator.showmessage('account created successfully');
      var user=MyUser(id: credential.user?.uid ?? '',
          firstname: firstname,
          lastname: lastname,
          Username: Username,
          email: email);
      print('id: ${credential.user?.uid}');
       try{
         var dataUser= await DatabaseUtils.registerUser(user);
         navigator.navigatetoHome(user);
       }
       catch(e){
         print(e.toString());
       }

    } on FirebaseAuthException catch (e) {
      if (e.code == firebaseErrors.weakPassword) {
        navigator.hideloading();
        navigator.showmessage('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == firebaseErrors.emailAlreadyInUse) {
        navigator.hideloading();
        navigator.showmessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideloading();
      navigator.showmessage('Something went wrong');
      print(e);
    }
  }
}