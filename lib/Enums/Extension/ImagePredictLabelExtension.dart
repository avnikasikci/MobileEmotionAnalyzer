import 'package:flutter_emotion/Enums/ImagePredictLabelEnum.dart';

extension ImagePredictLabelExtension on ImagePredictLabelEnum {
  String get rawValue {
    switch (this) {
      case ImagePredictLabelEnum.angry:
        return 'angry';
      case ImagePredictLabelEnum.disgust:
        return 'disgust';
      default:
        throw 'ERROR TYPE';
    }
  }
}
