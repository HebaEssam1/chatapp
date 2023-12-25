import 'package:chatapp/Database/Database_utils.dart';
import 'package:chatapp/firebase_errors.dart';
import 'package:chatapp/login/login_navigator.dart';
import 'package:chatapp/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier{
  late LoginNavigator navigator;
  Future<void> loginfirebaseAuth(String email,String password) async {
    try {
      navigator.showloading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      navigator.hideloading();
      navigator.showmessage('Logged in successfully');
      var userObj=DatabaseUtils.getUser(credential?.user?.uid ?? '');
      if(userObj==null){
        navigator.hideloading();
        navigator.showmessage('Something went wrong');
      }
      else{

        navigator.navigatetoHome(userObj as MyUser);
      }

    }
    on FirebaseAuthException catch (e) {
      if (e.code == firebaseErrors.userNotFound) {
        navigator.hideloading();
        navigator.showmessage('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == firebaseErrors.wrongPassword) {
        navigator.hideloading();
        navigator.showmessage('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }

}
}


