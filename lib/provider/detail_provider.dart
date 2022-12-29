import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_submission1/model/detail_model.dart';
// import 'package:restaurant_app/data/api/api_service.dart';
// import 'package:restaurant_app/data/model/review_model.dart';
import 'package:http/http.dart' as http;

import '../api_data/api_serv.dart';
import '../result_state.dart';


class DetailProvider extends ChangeNotifier {
  final ApiServ apiService;

  DetailProvider({required this.apiService, required String id}) {
    getRestaurantDetail(id);
  }

  late ResultState _state;
  late RestaurantDetail _detailRestaurant;
  String _message = '';

  
  RestaurantDetail get detail => _detailRestaurant;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> getRestaurantDetail(id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.getRestaurantDetail(id, http.Client());
      if (resto.restaurant.toJson().isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data is Empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = resto;
      }

    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

}
