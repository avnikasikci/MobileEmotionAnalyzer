import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeController extends ChangeNotifier {
  GetIt getIt = GetIt.I;

  String getToken() {
    //String _token = getIt<IUserTokenService>().getToken();
    String _token = 'aaa';
    if (_token == '') {
      return 'Hata';
    } else {
      return _token;
    }
  }
}
