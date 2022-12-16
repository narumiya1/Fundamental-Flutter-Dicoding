import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../api_data/api_serv.dart';
import '../model/list_model.dart';
import '../provider/detail_provider.dart';
import '../widgets/detail.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
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
}
