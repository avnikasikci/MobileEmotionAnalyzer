import 'package:flutter/material.dart';
import 'package:flutter_emotion/UI/Core/Constants/ColorConstant.dart';
import 'package:flutter_emotion/UI/controllers/layoutController.dart';
import 'package:flutter_emotion/UI/models/navigationItem.dart';
import 'package:provider/provider.dart';

AppBar appbar(BuildContext context) {
  final navigationItem = Provider.of<LayoutController>(context).navigationItem;
  String actionText = "";

  // switch (navigationItem) {
  //   case NavigationItem.home:
  //     actionText = "home";
  //     break;
  //   case NavigationItem.cameraAnalyzer:
  //     actionText = "Camera";
  //     break;
  //   case NavigationItem.galleryAnalyzer:
  //     actionText = "galleryAnalyzer";
  //     break;
  //   default:
  //     actionText = "home";
  // }

  return AppBar(
    backgroundColor: ColorConstants.instance.ebonyClay,
    actions: [

      Align(
        alignment: Alignment
            .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
        child: Text(
          actionText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
