import 'package:flutter/material.dart';
import 'package:restaurant_submission1/ui/favorite_page.dart';
import 'package:restaurant_submission1/ui/setting_page.dart';
import '../ui/restaurant_list.dart';



class BottomNavigationBarLst extends ChangeNotifier{

  int currrenIdx = 0 ;

  final List<Widget> listWidgets = [
    RestraurantLists(),
    FavoritePaage(),
    SettingPage()
  ];

  currentPage(int index){
    currrenIdx = index;
    notifyListeners();

  }

}