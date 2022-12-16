import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/model/list_model.dart';
import 'package:restaurant_submission1/provider/detail_provider.dart';
import 'package:restaurant_submission1/styles.dart';
import 'package:restaurant_submission1/widgets/detail.dart';

import 'api_data/api_serv.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;
  final DetailProvider provider;

  const RestaurantDetailPage(
      {required this.restaurant, required this.provider});

  @override
  Widget build(BuildContext context) {
    double mediumFontSize = 20;

    Color whiteColor = Color(0xffFFFFFF);

    TextStyle whteTextStyle = GoogleFonts.nunito(
      color: whiteColor,
    );
    DetailProvider _provider;
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(apiService: ApiServ(), id: restaurant.id),
      child: SafeArea(
        child: Scaffold(
          body: Consumer<DetailProvider>(
            builder: (context, state, _) {
              _provider = state;
              if (state.state == ResultState.Loading) {
                return Center(
                  child: SpinKitHourGlass(
                    color: Colors.amber,
                    size: 50,
                  ),
                );
              } else if (state.state == ResultState.HasData) {
                var restaurant = state.result.restaurant;
                return DetailRestaurant(
                  restaurant: restaurant,
                  provider: _provider,
                );
              } else if (state.state == ResultState.NoData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.Error) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/no-wifi.png", width: 100),
                    SizedBox(height: 10),
                    Text("Koneksi terputus!"),
                    ElevatedButton(
                      child: Text("refresh"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
              } else {
                return Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }

  /*return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: Column(
                children: [
                  Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      restaurant.pictureId,
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    color: secondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            // FavButton();
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 14.0),
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const Icon(
                    //   Icons.location_city_outlined,
                    //   size: 27,
                    //   color: Colors.white,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'City : ',
                              style: whteTextStyle.copyWith(
                                fontSize: mediumFontSize,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ${restaurant.city}',
                                  style: whteTextStyle.copyWith(
                                    fontSize: mediumFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    FavoriteButton(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: IgnorePointer(
                  child: RatingBar(
                    initialRating: restaurant.rating,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      half: Icon(
                        Icons.star_half,
                        color: Colors.amber,
                      ),
                      empty: Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                      ),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      restaurant.description,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Foods',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: restaurant.menus.foods
                            .map((food) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    color: thirdColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      food.name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Drinks',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: restaurant.menus.drinks
                            .map((drink) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    color: thirdColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      drink.name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  */

}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14.0),
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(
          color: Colors.amber,
          width: 1.5,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
        ),
      ),
    );
  }
}
