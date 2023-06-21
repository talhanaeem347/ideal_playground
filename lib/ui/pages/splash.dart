import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Center(child: Container(
        height: size.width * 0.6,
        width: size.width * 0.6,
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo.png"),
            fit: BoxFit.cover,
           )),
    )));

  }
}
