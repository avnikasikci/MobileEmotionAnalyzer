import 'package:flutter/material.dart';

class CameraAnalyzerView extends StatefulWidget {
  //const CameraAnalyzerView({Key? key}) : super(key: key);

  @override
  _CameraAnalyzerViewState createState() => _CameraAnalyzerViewState();
  late bool isLoading;
}

class _CameraAnalyzerViewState extends State<CameraAnalyzerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Emotion Detect'),
      ),
    );
  }
}
