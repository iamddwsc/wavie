import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wavie/common/api_constants.dart';
import 'package:wavie/common/constants/size_constants.dart';
import 'package:wavie/domain/entities/movie_entity.dart';

class MovieCategoryWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final String contentTitle;
  const MovieCategoryWidget(
      {Key? key, required this.movies, required this.contentTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(itemBuilder: (context, index) {
    //   final MovieEntity movie = movies[index];
    //   return Container(
    //       margin: EdgeInsets.all(5.0),
    //       child: CachedNetworkImage(
    //         imageUrl: movie.image_url!,
    //         fit: BoxFit.cover,
    //       ));
    // });
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
              reverse: true,
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
                print('${ApiConstants.BASE_IMAGE_URL}${movie.image_url}');
                return Container(
                    // height: ,
                    // width: 36,
                    margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Sizes.dimen_10),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ApiConstants.BASE_IMAGE_URL}${movie.image_url}',
                        fit: BoxFit.cover,
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
