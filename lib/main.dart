import 'package:chatapp/Home/home_screen.dart';
import 'package:chatapp/Register/register_screen.dart';
import 'package:chatapp/add_room/add_room_screen.dart';
import 'package:chatapp/chatpage/chat_screen.dart';
import 'package:chatapp/login/login_screen.dart';
import 'package:chatapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var userprovider=Provider.of<UserProvider>(context);
    return MaterialApp(
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
        HomeScreen.routeName : (context) => HomeScreen(),
        AddRoomScreen.routeName :(context) => AddRoomScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
      },
      initialRoute:userprovider.firebaseUser == null?
        LoginScreen.routeName: HomeScreen.routeName,
    );
  }
}

