import 'package:flutter/material.dart';

class LogoSize extends StatelessWidget {
  const LogoSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * 0.1,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/logo/roundlogo.jpg'),
        ),
      ),
    );
  }
}
