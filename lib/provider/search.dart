import 'package:flutter/cupertino.dart';
import 'package:restaurant_submission1/api_data/api_serv.dart';
import 'package:restaurant_submission1/model/search_model.dart';

import '../result_state.dart';
import 'package:http/http.dart' as http;


class  SearchProvider extends ChangeNotifier {
  final ApiServ restaurantApi;
  String query;

  SearchProvider({required this.restaurantApi, this.query = ''}) {
    _fetchSearchRestaurant(query);
  }

  late SearchRestaurant _searchRestaurant;
  late ResultState _state;
  String _message = '';

  // SearchRestaurant get result => _searchRestaurant;
  // SearchState get state => _state;
  // String get message => _message;

  SearchRestaurant get search => _searchRestaurant;
  ResultState get state => _state;
  String get message => _message;


  searchRestaurant(String newValue) {
    query = newValue;
    _fetchSearchRestaurant(query);
    notifyListeners();
  }


  Future _fetchSearchRestaurant(value) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await restaurantApi.search(query, http.Client());
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'data is empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error => $e';
    }
  }

}