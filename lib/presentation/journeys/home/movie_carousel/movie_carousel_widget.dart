import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/presentation/journeys/home/movie_page_view.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final int defaultIndex;
  const MovieCarouselWidget(
      {Key? key, required this.movies, required this.defaultIndex})
      : assert(defaultIndex >= 0, 'default index cannot be less than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //MovieAppBar(),
        MoviePageView(movies: movies, initialPage: defaultIndex)
      ],
    );
  }
}
