import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavie/di/get_it.dart';
import 'package:wavie/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:wavie/presentation/journeys/home/custom_appbar/custom_appbar.dart';
import 'package:wavie/presentation/journeys/home/movie_carousel/movie_carousel_header.dart';
import 'package:wavie/presentation/journeys/home/movie_carousel/movie_carousel_widget.dart';
import 'package:wavie/presentation/journeys/home/movie_category/movie_category_widget.dart';
import 'package:wavie/common/appcolors.dart' as appcolors;
import 'package:wavie/presentation/journeys/menu/menu_widget.dart';
import 'package:wavie/presentation/utils/custom_page_route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieCarouselBloc? movieCarouselBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    movieCarouselBloc?.add(CarouselLoadEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    movieCarouselBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          //color: Colors.transparent,
          //extendBody: true,

          //extendBodyBehindAppBar: true,
          body: NestedScrollView(
        floatHeaderSlivers: false,
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            //expandedHeight: 100.0,
            //foregroundColor: Colors.transparent,
            //collapsedHeight: 30.0,
            backgroundColor: Colors.black.withOpacity(1),
            shadowColor: Colors.black.withOpacity(0.1),
            floating: true,
            snap: true,
            pinned: true,
            centerTitle: true,
            elevation: 0,
            //scrolledUnderElevation: 0,
            stretch: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(left: 10.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 12.0),
                  // width: 32.0,
                  // height: 32.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: const AssetImage(
                            'assets/images/logo_w.png',
                          ))),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                        CustomPageRoute(
                            child: MenuWidget(), direction: AxisDirection.up));
                  },
                  child: Container(
                    //margin: EdgeInsets.only(right: 20.0), width: 32.0,
                    height: 32.0,
                    child: Image.asset(
                      'assets/images/avatar.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size(screenSize.width, 25.0),
              child: Container(
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
                        title: 'Categories', onTap: () => print('Categories')),
                  ],
                ),
              ),
            ),
          )
        ],
        body: SingleChildScrollView(
            child: MultiBlocProvider(
          providers: [
            BlocProvider<MovieCarouselBloc>(
              create: (context) => movieCarouselBloc!,
            ),
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
                  }
                  return const SizedBox();
                },
              ),
              BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
                builder: (context, state) {
                  if (state is MovieCarouselLoaded) {
                    //print(state.movies);
                    return MovieCategoryWidget(
                      movies: state.movies,
                      contentTitle: 'Trending',
                    );
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        )),
      )),
    );
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
