import 'package:flutter/material.dart';

class GaleryAnalyzerView extends StatefulWidget {
  //const GaleryAnalyzerView({Key? key}) : super(key: key);

  @override
  _GaleryAnalyzerViewState createState() => _GaleryAnalyzerViewState();
  late bool isLoading;
}

class _GaleryAnalyzerViewState extends State<GaleryAnalyzerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galery Emotion Detect'),
      ),
    );
  }
}
