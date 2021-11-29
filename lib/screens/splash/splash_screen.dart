import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moomentz/screens/signin/signin.dart';
import '../../common/common/SharePreference.dart';
import '../../common/common/navigation.dart';
import '../dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer.run(() async {
      var flag = await AppSharedPreferences.getValue(key: 'login') == 'success';
      if (flag) {
        Navigation.intentWithClearAllRoutes(context, DashboardScreen.routeName);
      } else {
        Navigation.intentWithClearAllRoutes(context, LoginScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 100,
            alignment: Alignment.center, // This is needed
            child: Image.asset(
              'images/Moomentz.png',
              fit: BoxFit.contain,
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}
