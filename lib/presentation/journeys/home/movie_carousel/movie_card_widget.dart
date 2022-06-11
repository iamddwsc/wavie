import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wavie/data/core/api_constants.dart';
import 'package:wavie/common/constants/size_constants.dart';
import 'package:wavie/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:wavie/presentation/journeys/movie_detail/movie_detail_widget.dart';

import '../../../utils/custom_page_route.dart';

class MovieCardWidget extends StatelessWidget {
  final int movieId;
  final String image_url;
  final String video_url;
  const MovieCardWidget({
    Key? key,
    required this.movieId,
    required this.image_url,
    required this.video_url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context, rootNavigator: true).push(
          CustomPageRoute(
              child: MovieDetailScreen(
                movieDetailArguments: MovieDetailArguments(movieId),
                video_url: video_url,
              ),
              direction: AxisDirection.up),
        ),
      },
      child: SizedBox(
        height: 200.0,
        //borderRadius: BorderRadius.circular(Sizes.dimen_16),
        child: CachedNetworkImage(
          height: 200,
          imageUrl: '${ApiConstants.BASE_SOURCE_URL}$image_url',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
