import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff333333),
      child: Hero(
        tag: 'logo',
        child: Center(
          child: Image.asset('images/logo_kabod.png',
              width: MediaQuery.of(context).size.width * 0.25),
        ),
      ),
    );
  }
}
