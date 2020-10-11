import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function onTap;
  final String buttonTitle;

  LoginButton({this.onTap,this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:  EdgeInsets.all(20.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Colors.green ),
        alignment: Alignment.center ,
        child: Text(
            buttonTitle,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}

