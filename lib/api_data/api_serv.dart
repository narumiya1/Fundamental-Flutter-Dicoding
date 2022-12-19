import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_submission1/model/search_model.dart';

import '../model/detail_model.dart';
import '../model/list_model.dart';
import '../model/review_model.dart';
// import '../restarurant_detail_page.dart';

class ApiServ {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String baseUrlImg = '${_baseUrl}images/';
  final String smallImageUrl = 'images/small/';
  final String mediumImageUrl = 'images/medium/';
  final String largeImageUrl = 'images/large/';
  final String restaurantSearchUrl = 'search?q=';
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
  Future<SearchRestaurant> search(query) async {
    final response =
        await http.get(Uri.parse("$_baseUrl$restaurantSearchUrl$query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant search');
    }
  }

  
  // image
  smallImage(pictureId) {
    String url = "$_baseUrl$smallImageUrl$pictureId";
    return url;
  }

  mediumImage(pictureId) {
    String url = "$_baseUrl$mediumImageUrl$pictureId";
    return url;
  }

  largeImage(pictureId) {
    String url = "$_baseUrl$largeImageUrl$pictureId";
    return url;
  }
}
