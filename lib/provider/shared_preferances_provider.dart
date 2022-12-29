
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProviders extends ChangeNotifier{
  SharedPreferenceProviders(){
   notificaionSwitchSettings();
  }

  bool notificationSwitchSettings = false;
  static const String notificationSwitchKey = 'notification_switch';

  void notificaionSwitchSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    notificationSwitchSettings = prefs.getBool(notificationSwitchKey) ?? false;
    notifyListeners();
  }

  void changeNotificationSettingCondition(value) async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(notificationSwitchKey, value);
    notificaionSwitchSettings();
  }
}