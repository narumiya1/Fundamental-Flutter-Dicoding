import 'package:flutter/material.dart';
import 'package:restaurant_submission1/data/database_helper.dart';

import '../result_state.dart';

class DatabaseProovider extends ChangeNotifier {
  final DatabaseHelper databaseHelpers;

  DatabaseProovider({required this.databaseHelpers}) {
    _getFavorite();
  }

  ResultState? _resultState;

  ResultState? get state => _resultState;

  String _message = '';

  String get message => _message;

  List<String> _favoriteList = [];

  List<String> get favorite => _favoriteList;

  void _getFavorite() async {
    _favoriteList = await databaseHelpers.getFavorite();
    if (_favoriteList.isNotEmpty) {
      _resultState = ResultState.hasData;
    } else {
      _resultState = ResultState.noData;
      _message = 'No Data';
    }
    notifyListeners();
  }

  void addFavourite(String restaurantId) async {
    try {
      await databaseHelpers.insertFavorite(restaurantId);
      _getFavorite();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  void removeFavourite(String id) async {
    try{
      await databaseHelpers.deleteFavorite(id);
      _getFavorite();
    }catch(e){
      _resultState = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<bool> isFav(String id) async{
    final favResraurant = await databaseHelpers.getFavoriteById(id);
    return favResraurant.isNotEmpty;
  }
}
