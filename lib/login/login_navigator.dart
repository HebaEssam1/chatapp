import 'package:chatapp/model/my_user.dart';

abstract class LoginNavigator{
  void showloading();
  void hideloading();
  void showmessage( String message);
  void navigatetoHome(MyUser user);
}