import 'dart:async';

import 'package:animate_icons/animate_icons.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:video_player/video_player.dart';
import 'package:wavie/common/constants/size_constants.dart';
import 'package:wavie/common/extensions/size_extensions.dart';
import 'package:wavie/data/models/boxes.dart';
import 'package:wavie/data/models/user.dart';
import 'package:wavie/di/get_it.dart';
import 'package:wavie/presentation/journeys/movie_detail/comment_widget.dart';
import 'package:wavie/presentation/journeys/movie_detail/movie_detail_app_bar.dart';
import 'package:wavie/presentation/themes/theme_text.dart';
import 'package:wavie/domain/entities/movie_detail_entity.dart';
import 'package:wavie/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:wavie/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:wavie/presentation/themes/app_colors.dart';
import '../../../common/extensions/string_extension.dart';

import '../../../common/screenutil/screenutil.dart';
import '../../../common/constants/api_constants.dart';
import '../../utils/custom_page_route.dart';
import 'big_poster.dart';
import 'movie_trailer_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;
  final String video_url;
  final Widget AppBar;

  const MovieDetailScreen(
      {Key? key,
      required this.movieDetailArguments,
      required this.video_url,
      this.AppBar = const MovieDetailAppBar()})
      : assert(movieDetailArguments != null, 'arguments must not be null'),
        super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _movieDetailBloc;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  AnimateIconController? animateIconController;

  final boxMyList = Boxes.getMyList();
  final boxTimeStamp = Boxes.getTimeStamp();
  bool isInMyList = false;
  bool isInMyListChanged = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _movieDetailBloc
        .add(MovieDetailLoadEvent(widget.movieDetailArguments.movieId));
    animateIconController = AnimateIconController();
    //print('ABC ${widget.movieDetailArguments}');
    if (boxTimeStamp.containsKey(widget.movieDetailArguments.movieId)) {
      isInMyList = true;
      isInMyListChanged = true;
    }
    initializePlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (videoPlayerController.value.isInitialized) {
      videoPlayerController.dispose();
      chewieController.dispose();
    }
    // videoPlayerController.dispose();
    // if (chewieController != null) {

    // }
    _movieDetailBloc.close();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    //print('${ApiConstants.BASE_SOURCE_URL}${widget.video_url}');
    videoPlayerController = VideoPlayerController.network(
      '${ApiConstants.BASE_SOURCE_URL}${widget.video_url}',
    );
    await Future.wait([
      videoPlayerController.initialize().catchError((e) {
        print(e);
      })
    ]);

    if (videoPlayerController.value.isInitialized) {
      _createChewieController();
      setState(() {});
    }
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      showOptions: true,
      autoInitialize: true,
      showControlsOnInitialize: true,
      hideControlsTimer: const Duration(seconds: 4),
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColor.progress_bar_color,
        handleColor: AppColor.progress_bar_color,
        backgroundColor: AppColor.progress_bar_background_color,
        bufferedColor: AppColor.progress_bar_buffed_color,
      ),
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await videoPlayerController.pause();
    currPlayIndex = currPlayIndex == 0 ? 1 : 0;
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: Container(
              margin: EdgeInsets.fromLTRB(
                  5.0, ScreenUtil.statusBarHeight + Sizes.dimen_4.h, 5.0, 0.0),
              child: widget.AppBar),
          preferredSize: Size(screenSize.width, 40.0)),
      body: SingleChildScrollView(
        child: BlocProvider<MovieDetailBloc>.value(
          value: _movieDetailBloc,
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailLoaded) {
                final movieDetailEntity = state.movieDetailEntity;
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigPoster(
                        movie: movieDetailEntity,
                      ),
                      GestureDetector(
                        onTap: () {
                          videoPlayerController.value.isInitialized
                              ? Navigator.of(context).push(
                                  CustomPageRoute(
                                      child: MovieTrailerWidget(
                                          chewieController: chewieController),
                                      direction: AxisDirection.up),
                                )
                              : null;
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          height: Sizes.dimen_20.h,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(2.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                size: Sizes.dimen_32,
                              ),
                              Text(
                                'Play',
                                style: TextStyle(
                                    color: AppColor.background,
                                    fontSize: Sizes.dimen_16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        //alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        height: Sizes.dimen_20.h,
                        decoration: BoxDecoration(
                            color: AppColor.button_background,
                            borderRadius: BorderRadius.circular(2.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download,
                              size: Sizes.dimen_24,
                              color: AppColor.white,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Download',
                              style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: Sizes.dimen_15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: const Text(
                          'Preview',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      videoPlayerController.value.isInitialized
                          ? Container(
                              height: 230.0,
                              // color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Chewie(
                                controller: chewieController,
                              ),
                            )
                          : Container(),
                      Container(
                        margin: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Text(
                          '${movieDetailEntity.description}',
                          style: Theme.of(context).textTheme.bodyText2,
                          //textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10.0,
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Builder(
                          builder: (context) {
                            List<Widget> widgets = [];
                            int castCount = movieDetailEntity.cast!.length;
                            String len = movieDetailEntity.cast![0] +
                                movieDetailEntity.cast![1];
                            //print(castCount);
                            for (int $i = 0; $i <= castCount - 1; $i++) {
                              if ($i < castCount - 1) {
                                if (len.length > 30 && $i == 1) {
                                  widgets.add(widget_item(
                                      movieDetailEntity.cast![$i], context,
                                      dot: true, trim: true));
                                } else
                                  widgets.add(widget_item(
                                      movieDetailEntity.cast![$i], context,
                                      dot: true));
                              } else
                                widgets.add(widget_item(
                                    movieDetailEntity.cast![$i], context,
                                    dot: false));
                            }
                            return DrewWidget(castCount, widgets, 'Cast');
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          //top: 10.0,
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Builder(
                          builder: (context) {
                            List<Widget> widgets = [];
                            int directorCount =
                                movieDetailEntity.director!.length;
                            String len = directorCount > 1
                                ? movieDetailEntity.director![0] +
                                    movieDetailEntity.director![1]
                                : movieDetailEntity.director![0];
                            //print(castCount);
                            for (int $i = 0; $i <= directorCount - 1; $i++) {
                              if ($i < directorCount - 1) {
                                if (len.length > 30 && $i == 1) {
                                  widgets.add(widget_item(
                                      movieDetailEntity.director![$i], context,
                                      dot: true, trim: true));
                                } else
                                  widgets.add(widget_item(
                                      movieDetailEntity.director![$i], context,
                                      dot: true));
                              } else
                                widgets.add(widget_item(
                                    movieDetailEntity.director![$i], context,
                                    dot: false));
                            }
                            return DrewWidget(
                                directorCount, widgets, 'Director');
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20.0, top: 15.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  Container(
                                    //padding: EdgeInsets.all(value),
                                    height: 32.0,
                                    child: AnimateIcons(
                                      startIcon: isInMyListChanged
                                          ? Icons.done
                                          : Icons.add,
                                      endIcon: isInMyListChanged
                                          ? Icons.add
                                          : Icons.done,
                                      controller: animateIconController!,
                                      size: isInMyList
                                          ? Sizes.dimen_30
                                          : Sizes.dimen_32,
                                      onStartIconPress: () {
                                        if (isInMyList) {
                                          print("ABC Clicked on Done Icon");
                                          // boxMyList.put(movieDetailEntity.movieId,
                                          //     movieDetailEntity);
                                          String t = boxTimeStamp.get(
                                                  movieDetailEntity.movieId) ??
                                              '';
                                          boxMyList.delete(t);
                                          boxTimeStamp.delete(
                                              movieDetailEntity.movieId);
                                          // boxMyList.flush();
                                          // boxMyList.watch();
                                          print('ABC deleted');
                                          setState(() {
                                            isInMyList = !isInMyList;
                                          });
                                          // print(
                                          //     'ABC start on DONE isInMyList = $isInMyList}');
                                          return !isInMyList;
                                        } else {
                                          print("ABC Clicked on Add Icon");
                                          String t = DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString();
                                          boxTimeStamp.put(
                                              movieDetailEntity.movieId, t);
                                          boxMyList.put(t, movieDetailEntity);
                                          // boxMyList.flush();
                                          // boxMyList.watch();
                                          //boxMyList.delete(movieDetailEntity.movieId);
                                          print('ABC added');
                                          setState(() {
                                            isInMyList = !isInMyList;
                                          });
                                          // print(
                                          //     'ABC start on ADD isInMyList = $isInMyList}');
                                          return isInMyList;
                                        }
                                      },
                                      onEndIconPress: () {
                                        //print("Clicked on Add Icon");
                                        if (isInMyList) {
                                          print("ABC Clicked on Done Icon");
                                          // boxMyList.put(movieDetailEntity.movieId,
                                          //     movieDetailEntity);
                                          String t = boxTimeStamp.get(
                                                  movieDetailEntity.movieId) ??
                                              '';
                                          boxMyList.delete(t);
                                          boxTimeStamp.delete(
                                              movieDetailEntity.movieId);
                                          // boxMyList.flush();
                                          // boxMyList.watch();
                                          print('ABC deleted');
                                          print('ABC -------------');
                                          setState(() {
                                            isInMyList = !isInMyList;
                                          });
                                          // print(
                                          //     'ABC end on DONE isInMyList = $isInMyList}');
                                          return !isInMyList;
                                        } else {
                                          print("ABC Clicked on Add Icon");
                                          String t = DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString();
                                          boxTimeStamp.put(
                                              movieDetailEntity.movieId, t);
                                          boxMyList.put(t, movieDetailEntity);
                                          // boxMyList.flush();
                                          // boxMyList.watch();
                                          //boxMyList.delete(movieDetailEntity.movieId);
                                          print('ABC added');
                                          print('ABC -------------');
                                          setState(() {
                                            isInMyList = !isInMyList;
                                          });
                                          // print(
                                          //     'ABC end on ADD isInMyList = $isInMyList}');
                                          return isInMyList;
                                        }
                                      },
                                      duration: Duration(milliseconds: 300),
                                      startIconColor: AppColor.white,
                                      endIconColor: AppColor.white,
                                      clockwise: false,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 5.0,
                                  // ),
                                  Text('My List',
                                      style: TextStyle(
                                          color: AppColor.details_grey)),
                                ],
                              ),
                            ),
                            ActionButton('assets/icons/like.png', 'Rate', () {
                              final movie = boxMyList.values.toList();
                              print('ABC My List length = ${movie.length}');
                            }),
                            // ActionButton('assets/icons/comment.png', 'Comment',
                            //     () {
                            //   print('Check Date Time');
                            //   print(DateTime.now().millisecondsSinceEpoch);
                            //   print(DateTime.now()
                            //       .millisecondsSinceEpoch
                            //       .runtimeType);
                            // }),
                            ActionButton('assets/icons/send.png', 'Send', () {
                              var z = Hive.box('authenticationBox');
                              print(z.get('token'));
                              var y = Hive.box<User>('myUserBox');
                              print(y.get('myUser')!.firstName);
                            }),
                          ],
                        ),
                      ),
                      Container(
                        width: 80.0,
                        height: 7.0,
                        margin: EdgeInsets.only(left: 10.0, top: 10.0),
                        decoration: BoxDecoration(color: AppColor.red),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(top: 5.0, left: 10.0, bottom: 20.0),
                        //width: 50.0,
                        child: Text(
                          'Comment',
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: Sizes.dimen_15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: CommentWidget(
                            movieId: widget.movieDetailArguments.movieId),
                      )
                    ],
                  ),
                );
              } else if (state is MovieDetailError) {
                return Container(
                  child: Text(state.errorType.toString()),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget DrewWidget(int castCount, List<Widget> widgets, String leading) {
    return Row(
      children: [
        castCount > 1
            ? Text(
                '${leading}s: ',
                style: TextStyle(color: Colors.grey),
              )
            : Text(
                '$leading: ',
                style: TextStyle(color: Colors.grey),
              ),
        if (widgets.length > 2) ...widgets.sublist(0, 2),
        if (widgets.length > 2)
          Text(
            '...',
            style: TextStyle(color: Colors.grey),
          ),
        if (widgets.length > 2)
          Text(
            ' more',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        if (widgets.length <= 2) ...widgets
      ],
    );
  }

  Widget ActionButton(String path, String name, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Image.asset(
                path,
                width: Sizes.dimen_22,
                height: Sizes.dimen_22,
                color: AppColor.white,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(name, style: TextStyle(color: AppColor.details_grey)),
          ],
        ),
      ),
    );
  }
}

Widget widget_item(String text, context, {bool dot = true, bool trim = false}) {
  return GestureDetector(
    onTap: () {
      print(text);
    },
    child: Text(
      trim
          ? (text + (dot ? ', ' : '')).intelliTrim()
          : (text + (dot ? ', ' : '')),
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: AppColor.details_grey),
      //overflow: TextOverflow.ellipsis,
    ),
  );
}
