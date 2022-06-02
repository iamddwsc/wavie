import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:wavie/screens/login.dart';
import 'package:wavie/presentation/themes/app_colors.dart';
import 'di/get_it.dart' as getIt;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(getIt.init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.from(colorScheme: colorScheme),
      //themeMode: ThemeMode.dark,
      title: 'Wavie App',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: AppColor.button,
          backgroundColor: Colors.black,
          //primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
          textTheme: Typography(platform: TargetPlatform.iOS).white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(elevation: 0)),
      home: const LoginPage(),
    );
  }
}
