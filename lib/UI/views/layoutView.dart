import 'package:flutter/material.dart';
import 'package:flutter_emotion/UI/controllers/layoutController.dart';
import 'package:flutter_emotion/UI/models/navigationItem.dart';
import 'package:flutter_emotion/UI/views/components/appbar.dart';
import 'package:flutter_emotion/UI/views/components/layoutDrawer.dart';
import 'package:flutter_emotion/UI/views/galeryAnalyzerView.dart';
import 'package:flutter_emotion/UI/views/homeView.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'cameraAnalyzerView.dart';

// ignore: must_be_immutable
class LayoutView extends StatefulWidget {
  LayoutView({Key? key}) : super(key: key);

  int pageNumber = 1;
  NavigationItem navigationItem = NavigationItem.home;

  @override
  _LayoutViewState createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  void initState() {
    super.initState();
    //Provider.of<LayoutController>(context, listen: false).syncTask();
  }

  @override
  Widget build(BuildContext context) {


    widget.pageNumber = Provider.of<LayoutController>(context).pageNumber;
    widget.navigationItem =
        Provider.of<LayoutController>(context).navigationItem;
    return Scaffold(
      drawer: LayoutDrawer(context),
      appBar: appbar(context),
      body: Consumer<LayoutController>(
        builder: (context, state, child) {
          switch (widget.navigationItem) {
            case NavigationItem.home:
              return HomeView();
            case NavigationItem.cameraAnalyzer:
              return CameraAnalyzerView();
            case NavigationItem.galleryAnalyzer:
              return GaleryAnalyzerView();
            default:
              return HomeView();
          }
        },
      ),
    );
  }
}
