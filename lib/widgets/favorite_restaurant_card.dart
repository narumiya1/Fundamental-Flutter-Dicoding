import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/provider/database_provider.dart';
import 'package:restaurant_submission1/provider/detail_provider.dart';
import 'package:restaurant_submission1/result_state.dart';

import '../api_data/api_serv.dart';

class FavoriteRestoCard extends StatefulWidget {
  final String restaurantId;
  const FavoriteRestoCard({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<FavoriteRestoCard> createState() => _FavoriteRestoCardState();
}

class _FavoriteRestoCardState extends State<FavoriteRestoCard> {

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProovider>(
      builder: (context, provider, child){
        return FutureBuilder(
            future: provider.isFav(widget.restaurantId),
            builder: (context, snapshot) {
              return ChangeNotifierProvider<DetailProvider>(
                create: (context) => DetailProvider(
                    apiService: ApiServ(),
                    id: widget.restaurantId),
                child: Consumer<DetailProvider>(
                  builder: (context, resultState, child){
                    if(resultState.state == ResultState.loading){
                      return const Center(
                        child: SpinKitCircle(
                          color: Color.fromARGB(255, 7, 143, 255),
                          size: 50,
                        ),

                      );
                    }else if (resultState.state == ResultState.hasData) {
                      return _buildCardRestaurant(resultState);
                    } else {
                      return Center(
                        child: Text(resultState.message),
                      );
                    }
                  },
                ),
              );


            },
        );
      },
    );
  }

  _buildCardRestaurant(DetailProvider resultState){
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail_page',
            arguments: widget.restaurantId);
      },
      // onTap: ()=>
      //     Navigationn.intentWithData(DetailPage.routeName, widget.restaurantId),
      child: Container(
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black12,
        ),
        width: double.maxFinite,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                ApiServ().largeImage(
                  resultState.detail.restaurant.pictureId,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resultState.detail.restaurant.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
                            resultState.detail.restaurant.address,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RatingBarIndicator(
                        rating: resultState.detail.restaurant.rating,
                        itemCount: 5,
                        itemSize: 15,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );

  }
}
