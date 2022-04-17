import 'package:flutter/material.dart';

class LogoSize extends StatelessWidget {
  const LogoSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size _size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/logo/roundlogo.jpg'),
        ),
      ),
    );
  }
}
