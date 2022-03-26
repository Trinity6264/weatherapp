import 'package:flutter/material.dart';
import 'package:weather/shared/color_pallet.dart';

const textDecor = InputDecoration(
  // border: InputBorder.none,
  filled: true,
  fillColor: whiteColor,
  enabled: true,
  hintText: 'Search City',
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: whiteColor,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: whiteColor,
    ),
  ),
);
