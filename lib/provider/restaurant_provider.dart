import 'dart:async';

import 'package:flutter/material.dart';

import '../api_data/api_serv.dart';
import '../result_state.dart';


class RestaurantProvider extends ChangeNotifier {
  final ApiServ apiService;

  RestaurantProvider({required this.apiService}) {
    getAllRestaurants();
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  dynamic get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> getAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.getRestaurantList();
      notifyListeners();
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = restaurantList;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
