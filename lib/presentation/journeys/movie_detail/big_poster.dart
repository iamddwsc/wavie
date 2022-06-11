import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wavie/common/constants/size_constants.dart';
import 'package:wavie/common/screenutil/screenutil.dart';
import 'package:wavie/presentation/themes/theme_text.dart';
import 'package:wavie/common/extensions/num_extensions.dart';
import 'package:wavie/common/extensions/size_extensions.dart';

import '../../../data/core/api_constants.dart';
import '../../../domain/entities/movie_detail_entity.dart';
import 'movie_detail_app_bar.dart';

class BigPoster extends StatelessWidget {
  final MovieDetailEntity movie;
  const BigPoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).primaryColor,
              ])),
          child: CachedNetworkImage(
            //height: MediaQuery.of(context).size.height * 0.7,
            //height: ScreenUtil.screenHeight * 0.7,
            imageUrl: '${ApiConstants.BASE_SOURCE_URL}${movie.imageUrl}',
            width: ScreenUtil.screenWidth,
          ),
        ),
        Positioned(
          left: -5,
          bottom: 0,
          right: 0,
          child: ListTile(
            title: Text(
              movie.title,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: ScreenUtil.screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    movie.year.toString(),
                    style: Theme.of(context).textTheme.greySubtitle1,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'rating: ' + movie.rating,
                    style: Theme.of(context).textTheme.greySubtitle1,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //   left: Sizes.dimen_16.w,
        //   right: Sizes.dimen_16.w,
        //   top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        //   child: Container(child: MovieDetailAppBar()),
        // ),
      ],
    );
  }
}
