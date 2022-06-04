import 'package:flutter/material.dart';

class BorderConstant {
  static final BorderConstant instance = BorderConstant._internal();

  BorderConstant._internal();

  final radiusAllCircular = RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
}
