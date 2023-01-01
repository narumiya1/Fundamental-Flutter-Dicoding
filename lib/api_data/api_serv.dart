import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_submission1/model/search_model.dart';

import '../model/detail_model.dart';
import '../model/list_model.dart';
// import '../restarurant_detail_page.dart';

class ApiServ {
  final String baseUrl = 'https://restaurant-api.dicoding.dev';
  final String restaurantListUrl = '/list';
  final String restaurantSearchUrl = '/search?q=';
  final String restaurantDetailUrl = '/detail/';

  final String smallImageUrl = '/images/small/';
  final String mediumImageUrl = '/images/medium/';
  final String largeImageUrl = '/images/large/';

  Future<RestaurantList> listRest(http.Client client) async {
    final response = await client.get(Uri.parse('$baseUrl$restaurantListUrl'));
    try {
      if (response.statusCode == 200) {
        return RestaurantList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to get restaurant list');
      }
    } on SocketException {
      throw 'No Internet Connection';
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(
      id, http.Client client) async {
    final response =
    await client.get(Uri.parse('$baseUrl$restaurantDetailUrl$id'));
    try {
      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to get detail restaurant');
      }
    }on SocketException{
      throw 'No Internet Connection';
    } catch(e){
      rethrow;
    }
  }


  Future<SearchRestaurant> search(query, http.Client client) async {
    final response =
        await client.get(Uri.parse("$baseUrl$restaurantSearchUrl$query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant search');
    }
  }

  // image
  smallImage(pictureId) {
    String url = "$baseUrl$smallImageUrl$pictureId";
    return url;
  }

  mediumImage(pictureId) {
    String url = "$baseUrl$mediumImageUrl$pictureId";
    return url;
  }

  largeImage(pictureId) {
    String url = "$baseUrl$largeImageUrl$pictureId";
    return url;
  }
}
