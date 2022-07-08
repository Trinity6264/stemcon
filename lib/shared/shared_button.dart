import 'package:flutter/material.dart';

import '../utils/color/color_pallets.dart';

class SharedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const SharedButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SizedBox(
      height: 50,
      width: 343,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
