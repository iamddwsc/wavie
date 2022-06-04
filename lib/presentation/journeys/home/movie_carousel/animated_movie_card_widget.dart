import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wavie/common/constants/size_constants.dart';
import 'package:wavie/common/extensions/size_extensions.dart';
import 'package:wavie/presentation/journeys/home/movie_carousel/movie_card_widget.dart';

class AnimatedMovieCardWidget extends StatelessWidget {
  final int index;
  final int movieId;
  final String image_url;
  final PageController pageController;
  const AnimatedMovieCardWidget(
      {Key? key,
      required this.index,
      required this.movieId,
      required this.image_url,
      required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double value = 1;
          if (pageController.position.haveDimensions) {
            value = pageController.page! - index;
            value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);

            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Curves.easeIn.transform(value) * 300,
                width: Sizes.dimen_230.w,
                child: child,
              ),
            );
          } else {
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: Curves.easeIn
                          .transform(index == 0 ? value : value * 0.5) *
                      300,
                  width: Sizes.dimen_230,
                  child: child),
            );
          }
        },
        child: MovieCardWidget(movieId: movieId, image_url: image_url));
  }
}
