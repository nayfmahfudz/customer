import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:customer/Login.dart';
import 'package:customer/component/api.dart';
import 'package:customer/menu.dart';
import 'package:customer/setting.dart';
import 'package:customer/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeService();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp();
// service.startService();
  @override
  State<MyApp> createState() => _MyAppState();
}

@override
class _MyAppState extends State<MyApp> {
  initState() {
    super.initState();
  }

  bool main = false;
  Future splashscreen() async {
    absen["masuk"] = "";
    absen["keluar"] = "";
    return await Future.delayed(Duration(seconds: 6), () async {
      final prefs = await SharedPreferences.getInstance();
      print(prefs.getString("user"));
      key = prefs.getString("key") ?? "";
      user =
          prefs.getString("user") == null || prefs.getString("user") == "null"
              ? {}
              : jsonDecode(prefs.getString("user") ?? "");
      await cekAbsen(context);
      await cekKunjungan(context);
      if (key == null || key == "" && user == null || user.length == 0) {
        main = false;
      } else {
        main = true;
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Breakpoint(
      // Use default sizes or override.
      breakpointData: BreakpointData(
        // Based on [ScreenSize] (xSmall , small , medium , large , xLarge)
        minSmallScreenWidth: 600,
        minMediumScreenWidth: 1024,
        minLargeScreenWidth: 1440,
        minXLargeScreenWidth: 1920,
        // Based on [ScreenType] (smallHandset , mediumHandset , largeHandset , smallTablet , largetablet , smallDesktop , mediumDesktop , largeDesktop)
        minMediumHandsetWith: 360,
        minLargeHandsetWith: 400,
        minSmallTabletWidth: 600,
        minLargeTabletWidth: 720,
        minSmallDesktopWidth: 1024,
        minMediumDesktopWidth: 1440,
        minLargeDesktopWidth: 1920,
      ),
      child: MaterialApp(
          title: 'Sales Online',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
            future: splashscreen(),
            builder: ((context, snapshot) {
              if (snapshot.data == true) {
                if (main) {
                  return Menu();
                } else {
                  return Login();
                }
              } else {
                return SplashScreen();
              }
            }),
          )),
    );
  }
}
