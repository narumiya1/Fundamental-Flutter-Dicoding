import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/provider/database_provider.dart';
import 'package:restaurant_submission1/result_state.dart';
import 'package:restaurant_submission1/ui/main_page.dart';
import 'package:restaurant_submission1/widgets/favorite_restaurant_card.dart';

class FavoritePaage extends StatelessWidget {
  const FavoritePaage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainPage())),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 19, horizontal: 22),
                child: Text(
                  "Favourite Restaurant",
                  style: TextStyle(fontSize: 27),
                ),
              ),
              Consumer<DatabaseProovider>(
                builder: (context, providers, child) {
                  if (providers.state == ResultState.loading) {
                    return Center(
                      child: SpinKitThreeBounce(
                        color: Color.fromARGB(255, 7, 143, 255),
                        size: 50,
                      ),
                    );
                  } else if (providers.state == ResultState.noData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3.5,
                          ),
                          const Icon(
                            MdiIcons.foodOutline,
                            size: 75,
                            color: Color(0xffd3d3d3),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'You don\'t have favorite resturant',
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
                  } else {
                    return _buildListFvorite(providers);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListFvorite(DatabaseProovider providers) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: providers.favorite.length,
        itemBuilder: (context, index) {
          var restIde = providers.favorite[index];
          return FavoriteRestoCard(restaurantId: restIde);
        },
      ),
    );
  }
}
