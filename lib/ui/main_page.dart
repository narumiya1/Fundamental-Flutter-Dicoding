import 'dart:async';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/styles.dart';
import 'package:restaurant_submission1/ui/detail_page.dart';
import 'package:restaurant_submission1/widgets/network_disconnected_widget.dart';

import '../main.dart';
import '../provider/bottom_navigation_bar.dart';
import '../utils/notification_helper.dart';
import 'dart:developer' as developer;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/main_page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log("Couldn't check connectivity status", error: e);
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
      _notificationHelper.configureSelectionNotificationSubject(
          context, DetailPage.routeName);
    });
    initConnectivity();
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        _connectionStatus = event;
      });
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    subscription.cancel();
    super.dispose();
  }

  final List<BottomNavyBarItem> _navyBarItems = [
    BottomNavyBarItem(
      icon: const Icon(MdiIcons.homeAccount),
      title: const Text('Home'),
      activeColor: secondaryColor,
    ),
    BottomNavyBarItem(
      icon: const Icon(MdiIcons.heartMultiple),
      title: const Text('Favorite'),
      activeColor: Colors.red,
    ),
    BottomNavyBarItem(
      icon: const Icon(MdiIcons.sawBlade),
      title: const Text('Settings'),
      activeColor: Colors.blueAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarLst>(
      builder: (context, page, child) => Scaffold(
        body: _connectionStatus == ConnectivityResult.none
            ? const NetworkDisconnected()
            : page.listWidgets[page.currrenIdx],
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 7),
          child: BottomNavyBar(
            curve: Curves.easeInOut,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            showElevation: false,
            items: _navyBarItems,
            onItemSelected: (index){
              page.currentPage(index);
            },
            selectedIndex: page.currrenIdx,
          ),
        ),
      ),
    );
  }
}
