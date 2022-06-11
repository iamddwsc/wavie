import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wavie/data/core/api_constants.dart';
import 'package:wavie/common/constants/size_constants.dart';
import 'package:wavie/domain/entities/movie_entity.dart';

import '../../../utils/custom_page_route.dart';
import '../../movie_detail/movie_detail_arguments.dart';
import '../../movie_detail/movie_detail_widget.dart';

class MovieCategoryWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final String contentTitle;
  const MovieCategoryWidget(
      {Key? key, required this.movies, required this.contentTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5.0, top: 15.0),
            alignment: Alignment.centerLeft,
            child: Text(
              contentTitle,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView.separated(
              reverse: false,
              shrinkWrap: true,
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 0.0,
                );
              },
              itemBuilder: (context, index) {
                final MovieEntity movie = movies[index];
                //print('${ApiConstants.BASE_IMAGE_URL}${movie.image_url}');
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CustomPageRoute(
                          child: MovieDetailScreen(
                            movieDetailArguments:
                                MovieDetailArguments(movie.movieId!),
                            video_url: movie.video_url!,
                          ),
                          direction: AxisDirection.up),
                    );
                  },
                  child: Container(
                      // height: ,
                      //width: 110,
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Sizes.dimen_10),
                        child: CachedNetworkImage(
                          imageUrl:
                              '${ApiConstants.BASE_SOURCE_URL}${movie.image_url}',
                          fit: BoxFit.cover,
                          width: 105.0,
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
