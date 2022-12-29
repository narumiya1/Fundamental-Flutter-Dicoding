
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:restaurant_submission1/api_data/api_serv.dart';
import 'package:restaurant_submission1/model/detail_model.dart';
import 'package:restaurant_submission1/model/list_model.dart';
import 'package:restaurant_submission1/model/search_model.dart';


void main() {
  group(
    'Testing Restaurant API ',
        () {
      test(
        'Return a list of restaurants',
            () async {
          final client = MockClient((request) async {
            final response = {
              "error": false,
              "message": "success",
              "count": 20,
              "restaurants": []
            };
            return Response(json.encode(response), 200);
          });
          expect(
            await ApiServ().listRest(client),
            isA<RestaurantList>(),
          );
        },
      );


      test(
        'for Restaurant Search',
            () async {
          final client = MockClient(
                (request) async {
              final response = {
                "error": false,
                "founded": 1,
                "restaurants": []
              };
              return Response(json.encode(response), 200);
            },
          );

          expect(await ApiServ().search('Restaurant Name', client),
              isA<SearchRestaurant>());
        },
      );
    },
  );
}
