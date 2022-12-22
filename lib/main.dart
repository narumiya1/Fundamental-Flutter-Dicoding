import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/api_data/api_serv.dart';
import 'package:restaurant_submission1/model/list_model.dart';
import 'package:restaurant_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_submission1/provider/search.dart';

import 'package:restaurant_submission1/styles.dart';
import 'package:restaurant_submission1/ui/detail_page.dart';
import 'package:restaurant_submission1/ui/search_page.dart';
import 'package:restaurant_submission1/utils/navigation.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantProvider(apiService: ApiServ()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SearchProvider(restaurantApi: ApiServ()),
        ),
      ],
     child: MaterialApp(
      title: 'Restaurant Apps',
      theme: ThemeData(

        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        textTheme: textTheme,
      ),
       initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) =>  HomePage(),
        DetailPage.routeName: (context) => DetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
            ),
        Search.routeName: (context) => const Search(),
      },
     )
    );
  }
}
