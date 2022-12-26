import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_submission1/model/list_model.dart';

import '../api_data/api_serv.dart';
import '../result_state.dart';
import 'package:http/http.dart' as http;

class RestaurantProvider extends ChangeNotifier {
  final ApiServ apiService;

  RestaurantProvider({required this.apiService}) {
    getAllRestaurants();
  }

  late RestaurantList _listRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ResultState get state => _state;

  RestaurantList get list => _listRestaurant;

  Future<dynamic> getAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      // final restaurantList = await apiService.getRestaurantList();
      final restaurant = await apiService.listRest();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'data is empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurant = restaurant;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
