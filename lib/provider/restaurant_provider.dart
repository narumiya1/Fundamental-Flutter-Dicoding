import 'dart:async';

import 'package:flutter/material.dart';

import '../api_data/api_serv.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiServ apiService;
  final String id;

  RestaurantProvider({required this.apiService, required this.id}) {
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
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantList = await apiService.getRestaurantList();
      notifyListeners();
      _state = ResultState.HasData;
      notifyListeners();
      return _restaurantResult = restaurantList;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
