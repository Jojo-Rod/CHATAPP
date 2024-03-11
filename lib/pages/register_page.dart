import 'package:flutter/material.dart';
import 'package:main/components/MyButton.dart';
import 'package:main/components/MyTextField.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.onTap});
  final void Function()? onTap; // for Sign In link

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp(){

  }
  final bool obscureText = false;

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
                height: 700,
                child: Column(
                  children: [
                    Icon(
                      Icons.message,
                      size: 100,
                      color: Colors.grey[800],
                    ),

                    const Text("Let's create an account for you!",
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
                    MyTextField(
                        controller: confirmPasswordController,
                        hintText: "Confirm password",
                        obscureText: !obscureText),
                    const SizedBox(
                      height: 20,
                    ),
                    // sign in

                    MyButton(
                        onTap: signUp,
                        text: "Sign Up")
                    // not a member
                    ,
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already a member? ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap : widget.onTap, 
                          child: const Text(
                            " Sign In",
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
