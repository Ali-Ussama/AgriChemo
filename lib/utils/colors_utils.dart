import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsUtils {
  static const primary = Color(0xffFFFFFF);
  static final purpleLite = Color.fromARGB(Color.getAlphaFromOpacity(0.2),76,36,104);
  static const primaryDark = Color(0xff502660);
  static const gradientBackground = [
    // Color(0xff50266f),
    // Color(0xee50266F),
    // Color(0x0050266F)
    ColorsUtils.primaryDark, Colors.black
  ];
  static const primaryAlpha = Color(0x3250266F);
  static const secondary = Color(0xff099042);
  static const secondaryAlpha = Color(0x32099042);
  static const yeloBlack = Color(0xff313F51);
  static const yeloDarkBlue = Color(0xff3D5E87);
  static const yeloLightBlue = Color(0xffF4F9FE);
  static const yeloOrange = Color(0xFFFB8C00);
  static const yeloGreenLight = Color(0xFFE2F3E2);
}