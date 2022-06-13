import 'package:flutter/material.dart';
import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/presentation/journeys/home/movie_carousel/movie_card_widget.dart';

class MoviePageView extends StatefulWidget {
  final List<MovieEntity> movies;
  final int initialPage;
  const MoviePageView(
      {Key? key, required this.movies, required this.initialPage})
      : assert(initialPage >= 0, 'default index cannot be less than 0'),
        super(key: key);

  @override
  State<MoviePageView> createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  late PageController _pageController;
  //ScreenUtil? screenUtil;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //screenUtil = new ScreenUtil();
    //screenUtil!.init();
    _pageController = PageController(
        initialPage: widget.initialPage,
        keepPage: false,
        viewportFraction: 1.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      //height: ScreenUtil.screenHeight * 0.35,
      height: 480,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          final MovieEntity movie = widget.movies[index];
          return MovieCardWidget(
            movieId: movie.movieId!,
            image_url: movie.image_url!,
            video_url: movie.video_url!,
          );
        },
        pageSnapping: true,
        itemCount: widget.movies.length,
        onPageChanged: (index) {},
      ),
    );
  }
}
