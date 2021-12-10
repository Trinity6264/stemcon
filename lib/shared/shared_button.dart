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
      height: _size.height * 0.1 / 1.8,
      width: double.infinity,
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
