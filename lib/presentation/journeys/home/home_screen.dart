import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavie/common/constants/route_constants.dart';
import 'package:wavie/common/extensions/size_extensions.dart';
import 'package:wavie/di/get_it.dart';
import 'package:wavie/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:wavie/presentation/blocs/movie_today/movie_today_bloc.dart';
import 'package:wavie/presentation/journeys/home/custom_appbar/custom_home_appbar.dart';
import 'package:wavie/presentation/widgets/app_error_widget.dart';
import 'package:wavie/presentation/journeys/home/movie_carousel/movie_carousel_header.dart';
import 'package:wavie/presentation/journeys/home/movie_carousel/movie_carousel_widget.dart';
import 'package:wavie/presentation/journeys/home/movie_category/movie_category_widget.dart';
import 'package:wavie/common/appcolors.dart' as appcolors;
import 'package:wavie/presentation/journeys/menu/menu_widget.dart';
import 'package:wavie/presentation/utils/custom_page_route.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/screenutil/screenutil.dart';
import '../../../data/models/boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  MovieCarouselBloc? movieCarouselBloc;
  MovieTodayBloc? movieTodayBloc;
  bool _visible = true;
  late final AnimationController _controller;
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    movieTodayBloc = getItInstance<MovieTodayBloc>();
    movieCarouselBloc?.add(CarouselLoadEvent());
    movieTodayBloc?.add(MovieTodayLoadEvent());
    // movieCarouselBloc?.add(getMovieTodayEvent());
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
    _scrollController = ScrollController()
      ..addListener(() {
        //print(_scrollController.offset);
        _scrollOffset = _scrollController.offset;
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    movieCarouselBloc?.close();
    _controller.dispose();
    _scrollController.dispose();
  }

  // Future<List<>>

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    var myToken = Boxes.getMyToken().get('token')!;
    var myUser = Boxes.getMyUser().get('myUser')!;
    return Scaffold(
        extendBodyBehindAppBar: true,
        //resizeToAvoidBottomInset: false,
        //resizeToAvoidBottomPadding: false,

        appBar: CustomHomeAppBar(
          controller: _controller,
          visible: _visible,
          scrollOffset: _scrollOffset,
          child: PreferredSize(
            preferredSize: Size(screenSize.width, 60.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  5.0, ScreenUtil.statusBarHeight + Sizes.dimen_4.h, 5.0, 0.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.05),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20.0,
                    spreadRadius: 10.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () =>
                              movieCarouselBloc?.add(CarouselLoadEvent()),
                          child: Container(
                            //margin: EdgeInsets.only(left: 10.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 12.0),
                            // width: 32.0,
                            // height: 32.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    // colorFilter: ColorFilter.mode(
                                    //     Colors.white.withOpacity(0.9),
                                    //     BlendMode.saturation),
                                    fit: BoxFit.fill,
                                    image: const AssetImage(
                                      'assets/images/logo_w.png',
                                    ))),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(RouteList.menu,
                                    arguments: {'token': myToken});
                            // Navigator.of(context, rootNavigator: true).push(
                            //     CustomPageRoute(
                            //         child: MenuWidget(),
                            //         direction: AxisDirection.up));
                          },
                          child: Container(
                            //margin: EdgeInsets.only(right: 20.0), width: 32.0,
                            height: 40.0,
                            child: CachedNetworkImage(
                                imageUrl: ApiConstants.BASE_SOURCE_URL +
                                    '/storage/users/' +
                                    myUser.photo!,
                                fit: BoxFit.cover),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 60, right: 60, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _AppBarButton(
                            title: 'TV Shows', onTap: () => print('TV Shows')),
                        _AppBarButton(
                            title: 'Movies', onTap: () => print('Movies')),
                        _AppBarButton(
                            title: 'Categories',
                            onTap: () => print('Categories')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: ((notification) {
            //print(notification.direction);
            //if (notification.metrics.axisDirection)
            if (notification.metrics.axis == Axis.vertical) {
              if (notification is UserScrollNotification) {
                var noti = notification as UserScrollNotification;
                if (noti.direction == ScrollDirection.forward) {
                  if (!_visible) setState(() => _visible = true);
                } else if (noti.direction == ScrollDirection.reverse) {
                  //print('reverse');
                  if (_visible) setState(() => _visible = false);
                }
              }
            }

            return true;
          }),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            //dragStartBehavior: DragStartBehavior.start,
            //physics: ScrollPhysics(parent: RangeMaintainingScrollPhysics()),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<MovieCarouselBloc>(
                    create: (context) => movieCarouselBloc!),
                BlocProvider<MovieTodayBloc>(
                    create: (context) => movieTodayBloc!),
              ],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
                    builder: (context, state) {
                      if (state is MovieCarouselLoaded) {
                        //print(state.movies);
                        return Stack(
                          children: <Widget>[
                            Container(
                              child: MovieCarouselWidget(
                                  movies: state.movies,
                                  defaultIndex: state.defaultIndex),
                            ),
                            //Positioned(bottom: 5.0, child: Text('data'))
                          ],
                        );
                      } else if (state is MovieCarouselError) {
                        //print(state.errorType);
                        return Center(
                          child: Container(
                            //margin: EdgeInsets.only(top: 50.0),
                            alignment: Alignment.center,
                            child: AppErrorWidget(
                              onPressed: () =>
                                  movieCarouselBloc?.add(CarouselLoadEvent()),
                              errorType: state.errorType,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
                    builder: (context, state) {
                      if (state is MovieCarouselLoaded) {
                        return MovieCategoryWidget(
                          movies: state.movies,
                          contentTitle: 'Trending',
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  BlocBuilder<MovieTodayBloc, MovieTodayState>(
                    builder: (context, state) {
                      if (state is MovieTodayLoaded) {
                        return MovieCategoryWidget(
                          movies: state.movies,
                          contentTitle: 'Movie Today',
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
                    builder: (context, state) {
                      if (state is MovieCarouselLoaded) {
                        //print(state.movies);
                        return MovieCategoryWidget(
                          movies: state.movies.reversed.toList(),
                          contentTitle: 'Popular',
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  BlocBuilder<MovieTodayBloc, MovieTodayState>(
                    builder: (context, state) {
                      if (state is MovieTodayLoaded) {
                        return MovieCategoryWidget(
                          movies: state.movies.reversed.toList(),
                          contentTitle: 'For You',
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  // FutureBuilder(
                  //   future:
                  //   ,builder: (context, snapshot) {
                  //   if (snapshot.connectionState == ConnectionState.done) {
                  //     return MovieCategoryWidget(
                  //       movies: snapshot.data,
                  //       contentTitle: 'Trending',
                  //     );
                  //   }
                  //   return SizedBox();
                  // }),
                  SizedBox(
                    height: 80.0,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _AppBarButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
    );
  }
}
