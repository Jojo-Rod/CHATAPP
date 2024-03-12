import 'package:flutter/material.dart';
import 'package:main/components/MyButton.dart';
import 'package:main/components/MyTextField.dart';
import 'package:main/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final void Function()? onTap; // for register link
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bool obscureText = false;
void signIn() async{
  final authService = Provider.of<AuthService>(context,listen:false);
  try{
    await authService.signInWithEmailandPassword(emailController.text, passwordController.text);
  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),));
  }
}
  // final void Function()? onTap

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        // icon
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: Container(
                // alignment: Alignment.center,
                // decoration: BoxDecoration(
                // border: Border.all(color: Colors.black)
                // ),
                width: 900,
                height: 500,
                child: Column(
                  children: [
                    Icon(
                      Icons.message,
                      size: 100,
                      color: Colors.grey[800],
                    ),

                    const Text("Welcome back you've been misssssed!",
                        style: TextStyle(fontSize: 24)),

                    // textfields
                    const SizedBox(
                      height: 50,
                    ),
                    // email

                    MyTextField(
                        controller: emailController,
                        hintText: "Enter email",
                        obscureText: obscureText),
                    const SizedBox(
                      height: 20,
                    ),
                    // password
                    MyTextField(
                        controller: passwordController,
                        hintText: "Enter password",
                        obscureText: !obscureText),
                    const SizedBox(
                      height: 20,
                    ),
                    // sign in

                    MyButton(
                        onTap: signIn,
                        text: "Sign In")
                    // not a member
                    ,
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onTap, // instance of class MyButton 
                          child: const Text(
                            " Register now",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
