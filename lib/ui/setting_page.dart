import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission1/provider/shared_preferances_provider.dart';

import '../provider/schedule_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const routeName = '/setting-page';

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    // return Consumer<SharedPreferenceProviders>(
    //   builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _notifications(),
              ],
            ),
          ),
        );
    //   },
    // );
  }

  _notifications() {

    return Consumer<SharedPreferenceProviders>(
      builder: (context, provider, child) {
        return ListTile(
          leading: const Icon(
            MdiIcons.bell,
            size: 25,
          ),
          title: const Text(
            'Notification',
            style: TextStyle(fontSize: 18),
          ),
          trailing: Consumer<ScheduleProvider>(
            builder: (context, schedule, child) {
              return Switch.adaptive(
                value: provider.notificationSwitchSettings,
                onChanged: (value) async {
                  schedule.scheduledNotification(value);
                  provider.changeNotificationSettingCondition(value);
                  if (value == true) {
                    Fluttertoast.showToast(
                      msg: 'Notification Enabled',
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black38,
                      textColor: Colors.white,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Notification Disabled',
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black38,
                      textColor: Colors.white,
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );

  }
}
