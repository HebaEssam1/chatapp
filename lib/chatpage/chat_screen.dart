import 'package:chatapp/chatpage/chat_navigator.dart';
import 'package:chatapp/chatpage/chat_viewmodel.dart';
import 'package:chatapp/chatpage/message_widget.dart';
import 'package:chatapp/model/Room.dart';
import 'package:chatapp/utils.dart' as Utils;
import 'package:chatapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatViewModel viewModel = ChatViewModel();
  String content = '';
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var userProvider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.currentUser = userProvider.user!;
    viewModel.loadMessages();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
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
                args.title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder(
                        stream:viewModel.streamMessages,
                        builder: (context, asyncsnapshot) {
                          if(asyncsnapshot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator());
                          }
                          else if(asyncsnapshot.hasError){
                            return Text(asyncsnapshot.error.toString());
                          }
                          else{
                            print('doneee');
                            var messageList=asyncsnapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                            return ListView.builder(
                                itemBuilder: (context, index){
                                  return MessageWidget(message: messageList[index]);},
                              itemCount:messageList.length ,
                            );
                          }
                        },
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            content = value;
                          },
                          controller: controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(4),
                              hintText: 'Tyoe a message',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20)))),
                        ),
                      ),
                      SizedBox(width: 4),
                      ElevatedButton(
                          onPressed: () {
                            sendmessage();
                          },
                          child: Row(
                            children: [
                              Text('Send'),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(Icons.send_outlined)
                            ],
                          ))
                    ],
                  )
                ],
              ),

            ))
      ]),
    );
  }

  void sendmessage() {
    viewModel.sendMessage(content);
  }

  @override
  void clearmessage() {
    controller.clear();
    // TODO: implement clearmessage
  }

  @override
  void showmessage(String message) {
    Utils.showmessage(context, message, 'ok', () {
      Navigator.pop(context);
    });
  }
}
