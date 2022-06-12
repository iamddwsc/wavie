import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wavie/common/extensions/size_extensions.dart';
import 'package:wavie/common/constants/api_constants.dart';
import 'package:wavie/data/models/boxes.dart';
import 'package:wavie/presentation/journeys/menu/my_list_app_bar.dart';
import 'package:wavie/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:wavie/presentation/journeys/movie_detail/movie_detail_widget.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/screenutil/screenutil.dart';
import '../../../domain/entities/movie_detail_entity.dart';
import '../../utils/custom_page_route.dart';

class MyListWidget extends StatefulWidget {
  const MyListWidget({Key? key}) : super(key: key);

  @override
  State<MyListWidget> createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double itemHeight = (screenSize.height - kToolbarHeight - 24) / 2;
    final double itemWidth = screenSize.width / 2;
    //final getMyList = Boxes.getMyList();
    //final myList2 = getMyList.values.toList().reversed.toList();
    //final scre
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
              margin: EdgeInsets.fromLTRB(
                  5.0, ScreenUtil.statusBarHeight + Sizes.dimen_4.h, 5.0, 0.0),
              child: MyListAppBar()),
          preferredSize: Size(screenSize.width, 40.0)),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<MovieDetailEntity>('myList').listenable(),
        builder: (context, Box<MovieDetailEntity> value, _) {
          final myList = value.values.toList().reversed.toList();
          //final list = value
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: itemWidth / itemHeight),
            shrinkWrap: true,
            itemCount: myList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(7.0),
                // margin: EdgeInsets.only(
                //     right: screenSize.width * 0.033,
                //     bottom: screenSize.width * 0.033),
                //height: 100.0,
                width: screenSize.width * 0.3,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CustomPageRoute(
                          isAlwaysDown: true,
                          child: MovieDetailScreen(
                              movieDetailArguments:
                                  MovieDetailArguments(myList[index].movieId),
                              video_url: myList[index].videoUrl,
                              AppBar: MyListAppBar(
                                title: '',
                                pop3: true,
                              )),
                          direction: AxisDirection.right),
                    );
                  },
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          '${ApiConstants.BASE_SOURCE_URL}${myList[index].imageUrl}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
