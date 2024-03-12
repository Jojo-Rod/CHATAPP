import 'package:flutter/material.dart';
import 'package:main/pages/login.dart';
import 'package:main/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginOrRegister = true;

  void togglePages(){
    setState((){
        showLoginOrRegister = !showLoginOrRegister;
    });
  }
  @override
  Widget build(BuildContext context){
    if(showLoginOrRegister){
      return LoginPage(onTap: togglePages,);
    }
    else{
      return Register(onTap: togglePages);

    }
  }
}