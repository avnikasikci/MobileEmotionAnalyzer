import 'package:flutter/material.dart';
import 'package:flutter_emotion/UI/widget/NavigationDrawerWidget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
  late bool isLoading;
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // widget._token =
    //     Provider.of<UserWebViewController>(context, listen: false).getToken();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // widget.isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavigationDrawerWidget(),

      appBar: AppBar(
        title: const Text('Home View'),
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     child: const Text('Open route'),
      //     onPressed: () {
      //       // Navigate to second route when tapped.
      //     },
      //   ),
      // ),
    );
  }
}
