import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/detail_model.dart';
import '../model/list_model.dart';
import '../model/review_model.dart';
import '../model/search_model.dart';
import '../restarurant_detail_page.dart';

class ApiServ {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String baseUrlImg = '${_baseUrl}images/';

  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to loaad');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<RestaurantSearch> getRestaurantSearchResult(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<ReviewResponse> postReview(CustomerReview review) async {
    var _review = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse(_baseUrl + "review"),
      body: _review,
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": "12345",
      },
    );
    if (response.statusCode == 200) {
      return ReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post');
    }
  }
}
