import 'package:flutter/material.dart';
import 'package:wavie/screens/home_control.dart';
import 'package:wavie/presentation/journeys/home/home_screen.dart';
import 'package:wavie/screens/discoverpage.dart';
import 'package:wavie/screens/dowloadspage.dart';
import 'package:wavie/screens/homepage.dart';
import 'package:wavie/presentation/journeys/search/search_screen.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;
  //final String? daySession;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (tabItem == "Page1")
      child = HomePage();
    else if (tabItem == "Page2")
      child = SearchPage();
    else if (tabItem == "Page3")
      child = DiscoverPage();
    else if (tabItem == "Page4") child = DownloadsPage();
    //else if (tabItem == "Page5") child = UserPage();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child ?? const HomeControl());
      },
    );
  }
}
