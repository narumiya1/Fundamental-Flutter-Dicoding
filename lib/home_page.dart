import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/api_data/api_serv.dart';
import 'package:restaurant_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_submission1/restarurant_detail_page.dart';
import 'package:restaurant_submission1/styles.dart';
import 'package:restaurant_submission1/widgets/list.dart';

import 'result_state.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RestaurantProvider provider;
  Icon _searchIcon = Icon(Icons.search);

  final TextEditingController _filter = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: _buildData(context),
    );
  }

  Widget _buildData(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiServ()),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          provider = state;
          if (state.state == ResultState.loading) {
            return Center(
              child: SpinKitThreeBounce(color: Colors.amber),
            );
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/no-wifi.png", width: 100),
                SizedBox(
                  height: 10,
                ),
                Text("Tidak ada Koneksi!"),
                ElevatedButton(
                  child: Text("refresh page"),
                  onPressed: () {
                    provider.getAllRestaurants();
                  },
                ),
              ],
            ));
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }

  Widget _showError(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

  void _search() {
    setState(() {});
  }
}
