import 'package:flutter/material.dart';
import 'package:main/components/MyButton.dart';
import 'package:main/components/MyDialog.dart';
import 'package:main/components/MyTextField.dart';
import 'package:main/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.onTap});
  final void Function()? onTap; // for Sign In link

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      // const MyDialog(title:"Password Mismatch", content:"Passwords don't match",);
        showDialogBox(context, "Password Mismatch","Passwords don't match");
    } else {
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.createEmailandPassword(
            emailController.text, passwordController.text);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  // final bool obscureText = false;
  bool isVisible1 = false;
  bool isVisible2 = false;
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
                      Icons.account_box,
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
                        obscureText: false,
                        suffixIcon: null,
                        ),
                    const SizedBox(
                      height: 20,
                    ),
                    // password
                    MyTextField(
                        controller: passwordController,
                        hintText: "Enter password",
                        obscureText: !isVisible1,
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            isVisible1 = !isVisible1;
                        });}
                        ,icon:isVisible1?const Icon(Icons.visibility_outlined):const Icon(Icons.visibility_off_outlined)
                        ),
                        ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                        controller: confirmPasswordController,
                        hintText: "Confirm password",
                        obscureText: !isVisible2,
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            isVisible2 = !isVisible2;
                        });}
                        ,icon:isVisible2?const Icon(Icons.visibility_outlined):const Icon(Icons.visibility_off_outlined)
                        ),
                        ),
                    const SizedBox(
                      height: 20,
                    ),
                    // sign in

                    MyButton(onTap: signUp, text: "Sign Up")
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
                          onTap: widget.onTap,
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
