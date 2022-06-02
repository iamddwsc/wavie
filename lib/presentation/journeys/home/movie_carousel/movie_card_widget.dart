import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wavie/common/api_constants.dart';
import 'package:wavie/common/constants/size_constants.dart';

class MovieCardWidget extends StatelessWidget {
  final int movieId;
  final String image_url;
  const MovieCardWidget(
      {Key? key, required this.movieId, required this.image_url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {print(movieId)},
      child: SizedBox(
        height: 200.0,
        //borderRadius: BorderRadius.circular(Sizes.dimen_16),
        child: CachedNetworkImage(
          height: 200,
          imageUrl: '${ApiConstants.BASE_IMAGE_URL}$image_url',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
