import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/api_data/api_serv.dart';
import 'package:restaurant_submission1/result_state.dart';
import 'package:restaurant_submission1/styles.dart';

import '../model/search_model.dart';
import '../provider/search.dart';

class Search extends StatefulWidget {

  const Search({Key? key}) : super(key: key);
  static const routeName = '/search';

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    final SearchProvider searchRestaurantProvider =
        Provider.of<SearchProvider>(context, listen: false);

    textEditingController =
        TextEditingController(text: searchRestaurantProvider.query);

  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
  
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
            child: Column(
              children: [
                Consumer<SearchProvider>(
                  builder: (context, state, _) {
                    return TextField(
                      onChanged: (value) {
                        Provider.of<SearchProvider>(context,
                                listen: false)
                            .searchRestaurant(value);
                      },
                      controller: textEditingController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Search Restaurant',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<SearchProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                     return Center(
                        child: SpinKitThreeBounce(color: Colors.amber),
                      );
                    } else if (state.state == ResultState.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.search.founded.toInt(),
                          itemBuilder: (context, index) {
                            final restaurant = state.search.restaurants[index];
                            return _buildRestaurantCard(context, restaurant);
                          },
                        ),
                      );
                    } else if (state.state == ResultState.noData) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height / 3.5,
                              ),
                            ),
                          
                            const Text(
                              'Couldn\'t find the restaurant you looking for',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffd3d3d3),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (state.state == ResultState.error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height / 3.5,
                              ),
                            ),
                          
                            const Text(
                              'Search Restaurant',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 24, 24, 24),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                            ),
                         
                            const Text(
                              'Search for your favorite restaurants',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 17, 14, 14),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
  
      } 
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page',
            arguments: restaurant.id);
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
       child: Image.network(
          ApiServ().mediumImage(restaurant.pictureId),
          width: 80,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name, style: textTheme.headline6),
          Row(
            children: [
              RatingBarIndicator(
                direction: Axis.horizontal,
                rating: restaurant.rating,
                itemCount: 5,
                itemSize: 15,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              Text(" (${restaurant.rating})")
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      subtitle: Text(restaurant.city),
      trailing: const Icon(Icons.chevron_right),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
