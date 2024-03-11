import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onTap, required this.text});
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 50,
        // padding: EdgeInsets.all(10),
        child: ElevatedButton(
          // style : ElevatedButton.styleFrom(backgroundColor: Colors.black),
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black),
          ),
          onPressed: null,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
