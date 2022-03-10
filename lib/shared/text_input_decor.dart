import 'package:flutter/material.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

final textInputDecor = InputDecoration(
  border: InputBorder.none,
  fillColor: whiteColor,
  enabled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      width: 1.0,
    ),
  ),
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      width: 1.0,
      color: primaryColor,
    ),
  ),
);
