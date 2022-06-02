import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wavie/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:wavie/presentation/journeys/home/movie_carousel/movie_carousel_widget.dart';

class MovieCarouselHeader extends StatelessWidget {
  final Widget widget;
  const MovieCarouselHeader({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [widget, Positioned(bottom: 5.0, child: Text('data'))],
    );
  }
}
