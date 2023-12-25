import 'package:chatapp/Home/home_screen.dart';
import 'package:flutter/material.dart';

void showloading(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            Padding(padding: EdgeInsets.all(10), child: Text(text))
          ],
        ),
      );
    },
  );
}

void showmessage(BuildContext context, String message, String posActiontext,
    Function posAction,
    {String? negActiontext, Function? negAction}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(actions: [
        TextButton(
            onPressed: () {
              posAction(context);
            },
            child: Text(posActiontext))
      ], content: Text(message));
    },
  );
}
void hideloading(BuildContext context){
  Navigator.pop(context);
}
