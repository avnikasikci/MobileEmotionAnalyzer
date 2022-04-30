import 'package:flutter/material.dart';
import 'package:flutter_emotion/UI/models/navigationItem.dart';
import 'package:get_it/get_it.dart';

class LayoutController extends ChangeNotifier {
  GetIt getIt = GetIt.I;
  NavigationItem _navigationItem = NavigationItem.home;
  NavigationItem get navigationItem => _navigationItem;

  int pageNumber = 1;

  changePage(int pageNumber) {
    this.pageNumber = pageNumber;
    notifyListeners();
  }

  void setNavigationItem(NavigationItem navigationItem) {
    _navigationItem = navigationItem;
    notifyListeners();
  }

  Future<void> syncTask() async {
    //Uygulama her açıldığında sabitler yenilenecektir.
  }

  setDefault() {
    pageNumber = 1;
    _navigationItem = NavigationItem.home;
  }

  changeBuilding(String flatName) {
    notifyListeners();
  }
}
