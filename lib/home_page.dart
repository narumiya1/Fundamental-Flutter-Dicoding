import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/api_data/api_serv.dart';
import 'package:restaurant_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_submission1/restarurant_detail_page.dart';
import 'package:restaurant_submission1/styles.dart';
import 'package:restaurant_submission1/widgets/list.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RestaurantProvider provider;
  Widget _appBar = Text(
    'RestaurantApp #2',
    style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900),
  );
  final TextEditingController _filter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submission Restaurant 2'),
      ),
      body: _buildData(context),
      /*FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          try {
            final RestaurantList localRestaurant =
                restaurantListFromJson(snapshot.data!);
            return ListView.builder(
              itemCount: localRestaurant.restaurants.length,
              itemBuilder: (context, index) {
                return _showList(context, localRestaurant.restaurants[index]);
              },
            );
          } catch (e) {
            return _showError(context);
          }
        },
      ),
      */
    );
  }

  Widget _buildData(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiServ(), id: ''),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          provider = state;
          if (state.state == ResultState.Loading) {
            return Center(
              child: SpinKitThreeBounce(color: Colors.amber),
            );
          } else if (state.state == ResultState.HasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
            );
          } else if (state.state == ResultState.NoData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.Error) {
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
}
