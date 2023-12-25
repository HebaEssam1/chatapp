import '../model/my_user.dart';

abstract class RegisterNavigator {
  void showloading();
  void hideloading();
  void showmessage(String message);
  void navigatetoHome(MyUser user);
}