import 'package:flutter_emotion/UI/models/imageAnalyzeModel.dart';

class ImageAnalyzeLabelModel {
  final String labelTxt;
  bool expanded;
  final List<ImageAnalyzeModel>? modelList;

  ImageAnalyzeLabelModel(this.labelTxt, this.expanded, this.modelList);
}
