import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:wavie/common/constants/route_constants.dart';
import 'package:wavie/presentation/journeys/menu/menu_widget.dart';
import 'package:wavie/presentation/journeys/menu/my_list_widget.dart';
import 'package:wavie/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:wavie/presentation/journeys/movie_detail/movie_trailer_widget.dart';
import 'package:wavie/presentation/wavie_app.dart';

import '../data/models/movie_model.dart';
import '../screens/login.dart';
import 'journeys/movie_detail/movie_detail_widget.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        RouteList.init: (context) => const LoginPage(),
        RouteList.home: (context) => const WavieApp(),
        RouteList.movieDetail: (context) => MovieDetailScreen(
            movieDetailArguments: settings.arguments as MovieDetailArguments,
            video_url: settings.arguments as String),
        RouteList.watchMovie: (context) => MovieTrailerWidget(
            chewieController: settings.arguments as ChewieController),
        RouteList.menu: (context) => MenuWidget(
              token: settings.arguments as Map<String, String>,
            ),
        RouteList.myList: (context) => MyListWidget(),
      };
}
