import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wavie/data/models/movie_model.dart';

import '../../../common/constants/api_constants.dart';
import '../../utils/custom_page_route.dart';
import '../movie_detail/movie_detail_arguments.dart';
import '../movie_detail/movie_detail_widget.dart';

class SearchedItemWidget extends StatelessWidget {
  final List<MovieModel> movies;
  const SearchedItemWidget({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              CustomPageRoute(
                  child: MovieDetailScreen(
                    movieDetailArguments:
                        MovieDetailArguments(movies[index].movieId!),
                    video_url: movies[index].video_url!,
                  ),
                  direction: AxisDirection.up),
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      '${ApiConstants.BASE_SOURCE_URL}${movies[index].image_url!}',
                  fit: BoxFit.cover,
                  width: 125.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        movies[index].title!,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        movies[index].description!,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
