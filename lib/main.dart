import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/api_data/api_serv.dart';
import 'package:restaurant_submission1/data/database_helper.dart';
import 'package:restaurant_submission1/provider/bottom_navigation_bar.dart';
import 'package:restaurant_submission1/provider/database_provider.dart';
import 'package:restaurant_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_submission1/provider/schedule_provider.dart';
import 'package:restaurant_submission1/provider/search.dart';
import 'package:restaurant_submission1/provider/shared_preferances_provider.dart';

import 'package:restaurant_submission1/styles.dart';
import 'package:restaurant_submission1/ui/detail_page.dart';
import 'package:restaurant_submission1/ui/main_page.dart';
import 'package:restaurant_submission1/ui/search_page.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
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
              create: (context)=>BottomNavigationBarLst(),),
          ChangeNotifierProvider(
              create: (context) =>
                  DatabaseProovider(databaseHelpers: DatabaseHelper())),
          ChangeNotifierProvider(
            create: (context) => RestaurantProvider(apiService: ApiServ()),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchProvider(restaurantApi: ApiServ()),
          ),
          ChangeNotifierProvider(
            create: (context) => ScheduleProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SharedPreferenceProviders(),
          ),
        ],
        child: MaterialApp(
          title: 'Restaurant Apps',
          theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: primaryColor,
            textTheme: textTheme,
          ),
          initialRoute: MainPage.routeName,
          routes: {
            MainPage.routeName: (context) => MainPage(),
            DetailPage.routeName: (context) => DetailPage(
                  id: ModalRoute.of(context)?.settings.arguments as String,
                ),
            Search.routeName: (context) => const Search(),
          },
        ));
  }
}
