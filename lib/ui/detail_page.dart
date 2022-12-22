import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant_submission1/home_page.dart';
import 'package:restaurant_submission1/model/detail_model.dart';
import 'package:restaurant_submission1/styles.dart';
import 'package:restaurant_submission1/widgets/expanded_text.dart';

import '../api_data/api_serv.dart';
import '../provider/detail_provider.dart';
import '../result_state.dart';
import '../widgets/detail.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  static const routeName = '/detail_page';

  // final Restaurant restaurant;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (context) => DetailProvider(
        apiService: ApiServ(),
        id:id,
      ),
      child: Scaffold(
        body: Consumer<DetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: SpinKitThreeBounce(
                  color: Color.fromARGB(255, 7, 143, 255),
                  size: 50,
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        },
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          size: 35,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    pinned: true,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        ApiServ().largeImage(state.detail.restaurant.pictureId),
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(95),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 20, bottom: 10),
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.detail.restaurant.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                      Text(
                                        state.detail.restaurant.city,
                                        style: textTheme.bodyText1,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  _rating(state.detail.restaurant),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ExpandedText(
                            text: state.detail.restaurant.description,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8,left: 23, bottom: 10),
                          child: Text(
                            'Menu',
                            style: textTheme.headlineMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),

                          child: Text(
                            'Drinks',
                            style: textTheme.headlineSmall,
                          ),

                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: state.detail.restaurant.menus.drinks
                                  .map((food) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: detailColor,
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
                        // _buildDrinks(context, state.detail.restaurant),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Foods',
                            style: textTheme.headlineSmall,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: state.detail.restaurant.menus.foods
                                  .map((food) => Container(

                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: detailColor,
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
                        // _buildFoods(context, state.detail.restaurant),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('No Internet Connection'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _rating(Restaurant restaurant) {
    return Row(
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
        Text(
          ' (${restaurant.rating})',
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
