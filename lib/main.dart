import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wavie/common/constants/route_constants.dart';
import 'package:wavie/data/models/movie_detail_model.dart';
import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/data/models/user.dart';
import 'package:wavie/domain/entities/movie_detail_entity.dart';
import 'package:wavie/presentation/routes.dart';
import 'package:wavie/presentation/utils/fade_page_route.dart';

import 'package:wavie/screens/login.dart';
import 'package:wavie/presentation/themes/app_colors.dart';
import 'common/screenutil/screenutil.dart';
import 'di/get_it.dart' as getIt;
import 'presentation/themes/theme_text.dart';

void main() async {
  unawaited(getIt.init());
  await Hive.initFlutter();
  Hive.registerAdapter(MovieDetailEntityAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<MovieDetailEntity>('currentPlaying');
  await Hive.openBox<MovieDetailEntity>('myList');
  await Hive.openBox<bool>('isAlwaysDown');
  await Hive.openBox<String>('timeStamp');
  await Hive.openBox<User>('myUserBox');
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.from(colorScheme: colorScheme),
      //themeMode: ThemeMode.dark,
      title: 'Wavie App',
      theme: ThemeData(
        //unselectedWidgetColor: AppColor.royalBlue,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: AppColor.background,
        backgroundColor: Colors.black,
        //primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
        textTheme: ThemeText.getTextTheme(),
        //visualDensity: VisualDensity.adaptivePlatformDensity,
        //appBarTheme: const AppBarTheme(elevation: 0),
      ),
      // home: const LoginPage(),
      builder: (context, widget) {
        return widget!;
      },
      initialRoute: RouteList.init,
      onGenerateRoute: (RouteSettings settings) {
        final routes = Routes.getRoutes(settings);
        final WidgetBuilder? builder = routes[settings.name];
        return FadePageRouteBuilder(child: builder!, settings: settings);
      },
    );
  }
}
