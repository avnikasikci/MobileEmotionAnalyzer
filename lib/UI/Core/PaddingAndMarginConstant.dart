import 'package:flutter/material.dart';

class PaddingAndMarginConstant {
  static final PaddingAndMarginConstant instance = PaddingAndMarginConstant._internal();

  PaddingAndMarginConstant._internal();

  final allXLarge = EdgeInsets.all(32);

  final allLarge = EdgeInsets.all(24);

  final allMedium = EdgeInsets.all(16);

  final allSmall = EdgeInsets.all(8);

  final allXSmall = EdgeInsets.all(4);
  
  final allXXSmall = EdgeInsets.all(2);

  final topMedium = EdgeInsets.only(top: 16);

  final topSmall = EdgeInsets.only(top: 8);

  final bottomXLarge = EdgeInsets.only(bottom: 32);

  final symmetricMedium = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  final horizontalLarge = EdgeInsets.symmetric(horizontal: 32, vertical: 8);
}
