import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/api_data/api_serv.dart';
import 'package:restaurant_submission1/model/list_model.dart';
import 'package:restaurant_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_submission1/provider/search.dart';

import 'package:restaurant_submission1/styles.dart';
import 'package:restaurant_submission1/ui/detail_page.dart';
import 'package:restaurant_submission1/ui/search_page.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        textTheme: textTheme,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        // RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
        //       restaurant:
        //           ModalRoute.of(context)?.settings.arguments as Restaurant,
        //     ),
        DetailPage.routeName: (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
        Search.routeName: (context) => const Search(),
      },
     )
    );
  }
}
