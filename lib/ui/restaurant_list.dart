import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/api_data/api_serv.dart';
import 'package:restaurant_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_submission1/styles.dart';
import 'package:restaurant_submission1/widgets/network_disconnected_widget.dart';
import 'package:restaurant_submission1/widgets/title_widget.dart';

import '../model/list_model.dart';
import '../result_state.dart';
import 'dart:developer' as developer;

class RestraurantLists extends StatefulWidget {
  const RestraurantLists({Key? key}) : super(key: key);

  static const routeName = '/home_page';

  @override
  State<RestraurantLists> createState() => RestraurantListsState();
}

class RestraurantListsState extends State<RestraurantLists> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;
  Icon _searchIcon = Icon(Icons.search);

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log("Couldn't check connectivity status", error: e);
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }



  @override
  void initState() {
    initConnectivity();
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        _connectionStatus = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus != ConnectivityResult.none) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Submission Restaurant 2'),
          leading: IconButton(
            icon: _searchIcon,
            iconSize: 30,
            // onPressed:
            // _search,
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ),
        body: SafeArea(

          child: Container(
            padding: const EdgeInsets.only(
              top: 24,
              left: 15,
              right: 15,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Consumer<RestaurantProvider>(
                  builder: (context, value, _) {
                    if (value.state == ResultState.loading) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                          ),
                          const Center(
                            child: SpinKitThreeBounce(
                              color: Color.fromARGB(255, 7, 143, 255),
                              size: 50,
                            ),
                          ),
                        ],
                      );
                    } else if (value.state == ResultState.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.list.restaurants.length,
                          itemBuilder: (context, index) {
                            final restaurant = value.list.restaurants[index];
                            return _buildRestaurantCard(context, restaurant);
                          },
                        ),
                      );
                    } else if (value.state == ResultState.noData) {
                      return Center(
                        child: Text(value.message),
                      );
                    } else {
                      return const Center(
                        child: Text('No Internet Connection'),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ),
      );
    }else{

      return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              top: 24,
              left: 15,
              right: 15,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed:() {},
                      icon: const Icon(
                        Icons.restaurant_menu_outlined,
                        size: 33,
                      ),
                    ),

                    SizedBox(width: 14),

                    const TitleWidget(),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                const NetworkDisconnected(),
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
      subtitle: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 15,
            color: Colors.redAccent,
          ),
          Text(restaurant.city),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
