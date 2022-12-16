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
  Icon _iconSearch = Icon(Icons.search);
  Widget _appBar = Text(
    'RestaurantApp #2',
    style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900),
  );
  final TextEditingController _filter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Apps Subm 2'),
        leading: IconButton(
          icon: _iconSearch,
          iconSize: 30,
          onPressed: _search,
        ),
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
              child: SpinKitHourGlass(color: Colors.amber),
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
                Text("Koneksi terputus!"),
                ElevatedButton(
                  child: Text("refresh"),
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

  /*
  Widget _showList(BuildContext context, Restaurant restaurant) {
    return Material(
      color: primaryColor,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Stack(
              children: [
                Image.network(
                  restaurant.pictureId,
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x80000000),
                        Color(0x80000000),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text(
                        restaurant.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.location_pin,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: restaurant.city,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: restaurant.rating.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  */
  Widget _showError(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

  void _search() {
    setState(() {
      if (this._iconSearch.icon == Icons.search) {
        this._iconSearch = Icon(Icons.close);
        this._appBar = TextField(
          controller: _filter,
          cursorColor: Colors.white,
          decoration: InputDecoration(hintText: 'Cari nama restoran'),
          onChanged: (query) => {
            if (query != '')
              {
                provider.getRestaurantSearchResult(query),
              }
          },
        );
      } else {
        this._iconSearch = Icon(Icons.search);
        this._appBar = Text('RestaurantApp #2',
            style: Theme.of(context).textTheme.headline5);
        provider.getAllRestaurants();
        _filter.clear();
      }
    });
  }
}
