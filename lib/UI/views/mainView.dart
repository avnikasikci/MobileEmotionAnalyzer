import 'package:flutter/material.dart';
import 'package:flutter_emotion/UI/models/navigationItem.dart';
import 'package:flutter_emotion/UI/provider/navigationProvider.dart';
import 'package:flutter_emotion/UI/views/cameraAnalyzerView.dart';
import 'package:flutter_emotion/UI/views/homeView.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) => buildPages();

  Widget buildPages() {
    final provider = Provider.of<NavigationProvider>(context);
    final navigationItem = provider.navigationItem;

    switch (navigationItem) {
      case NavigationItem.home:
        return HomeView();
      case NavigationItem.cameraAnalyzer:
        return CameraAnalyzerView();
      default:
        return HomeView();
    }
  }
}
