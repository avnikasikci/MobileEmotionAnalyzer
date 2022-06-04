import 'package:flutter_emotion/UI/Core/BorderConstant.dart';
import 'package:flutter_emotion/UI/Core/Constants/ColorConstant.dart';
import 'package:flutter_emotion/UI/Core/PaddingAndMarginConstant.dart';

abstract class IBaseState {
  ColorConstants colorConstants = ColorConstants.instance;
  BorderConstant borderConstant = BorderConstant.instance;
  PaddingAndMarginConstant paddingAndMarginConstant =
      PaddingAndMarginConstant.instance;
}
