import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wavie/common/constants/api_constants.dart';
import 'package:wavie/common/constants/size_constants.dart';
import 'package:wavie/common/screenutil/screenutil.dart';
import 'package:wavie/data/models/comment_model.dart';
import 'package:wavie/presentation/journeys/movie_detail/comment_option_panel.dart';

import '../../../data/models/user.dart';
import '../../../common/extensions/string_extension.dart';

class CommentWidget extends StatefulWidget {
  final int movieId;
  const CommentWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  var list_comments = ValueNotifier<List<CommentModel>>([]);
  final Client _client = Client();
  //late PanelController _panelController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    // _panelController = PanelController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _panelController
    //_panelController.close();
    super.dispose();
  }

  void getData() async {
    list_comments.value = await _fetchComments(widget.movieId);
  }

  Future<List<CommentModel>> _fetchComments(int movieId) async {
    final response = await _client.post(
      Uri.parse(ApiConstants.BASE_URL + ApiConstants.GET_MOVIE_COMMENTS),
      body: jsonEncode({'movieId': movieId.toString()}),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    final String jsonBody = response.body;
    final int statusCode = response.statusCode;
    if (statusCode != 200 || jsonBody == null) {
      print(response.reasonPhrase);
      throw new Exception("Lỗi load api");
    } else {
      final comments =
          CommentModelResult.fromJson(json.decode(response.body)).comments;
      return comments!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var myUserBox = Hive.box<User>('myUserBox');
    var myUser = myUserBox.get('myUser');
    return ValueListenableBuilder(
      valueListenable: list_comments,
      builder: (context, List<CommentModel> value, _) {
        return ListView.builder(
          padding: EdgeInsets.only(top: 5.0),
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: value.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onDoubleTap: () {
                // print('removing');

                setState(() {
                  list_comments.value.removeAt(index);
                });
                // list_comments.;
                // print(list_comments.value);
                // print(value.length);
              },
              // child: ListTile(
              //   title: Text(value[index].comment!),
              //   subtitle: Text(
              //     value[index].user!.firstName!,
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              child: Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      child: CachedNetworkImage(
                          imageUrl: ApiConstants.BASE_SOURCE_URL +
                              '/storage/users/' +
                              value[index].user!.photo!,
                          fit: BoxFit.cover),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      //height: 70.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${value[index].user!.firstName} ${value[index].user!.lastName}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontSize: Sizes.dimen_16,
                                    fontWeight: FontWeight.w600),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(size.width * 0.7),
                            child: Text(
                              value[index].comment!.intelliTrimWithDot(),
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (myUser!.userId == value[index].user!.userId)
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.more_horiz_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              //list_comments.value.removeAt(index);
                              //_panelController.open();
                            });
                          },
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
