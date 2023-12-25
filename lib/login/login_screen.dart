import 'dart:async';

import 'package:chatapp/Register/register_screen.dart';
import 'package:chatapp/login/login_navigator.dart';
import 'package:chatapp/login/login_view_model.dart';
import 'package:chatapp/model/my_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/utils.dart' as Utils;

import '../Home/home_screen.dart';
import '../provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  LoginViewModel viewModel = LoginViewModel();

  var formKey = GlobalKey<FormState>();

  String email = '';

  String password = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
                'Login',
                style: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        TextFormField(
                          validator: (text) {
                            final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text!);
                            if (!emailValid) {
                              return 'email not in correct format';
                            }
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: ' Enter email',
                              labelStyle: TextStyle(
                                fontSize: 18,
                              )),
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        TextFormField(
                          validator: (text) {
                            if (text!.length < 6) {
                              return 'password must be at least 6 characters';
                            }
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: ' Enter password',
                              labelStyle: TextStyle(
                                fontSize: 18,
                              )),
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              formSubmit();
                            },
                            child: Text('Login')),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RegisterScreen.routeName);
                            },
                            child: Text('Do not have an account'))
                      ],
                    ),
                  )),
            ),
          ),
        ]

      ),
    );
  }

  void formSubmit() {
    if (formKey.currentState?.validate() == true) {
      viewModel.loginfirebaseAuth(email, password);
    }
  }

  @override
  void hideloading() {
    // TODO: implement hideloading
    Utils.hideloading(context);
  }

  @override
  void showloading() {
    // TODO: implement showloading\
    Utils.showloading(context, 'loading');
  }

  @override
  void showmessage(message) {
    // TODO: implement showmessage
    Utils.showmessage(context, message, 'ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void navigatetoHome(MyUser user) {
    var userprovider=Provider.of<UserProvider>(context,listen: false);
    userprovider.user=user;
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName );
    });


  }
}
