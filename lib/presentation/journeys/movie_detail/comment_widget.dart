import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wavie/data/core/api_constants.dart';
import 'package:wavie/data/models/comment_model.dart';

import '../../../data/models/user.dart';

class CommentWidget extends StatefulWidget {
  final int movieId;
  const CommentWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  var list_comments = ValueNotifier<List<CommentModel>>([]);
  final Client _client = Client();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
    //print(jsonBody);
    if (statusCode != 200 || jsonBody == null) {
      print(response.reasonPhrase);
      throw new Exception("Lỗi load api");
    } else {
      //final JsonDecoder _decoder = new JsonDecoder();
      //final list = _decoder.convert(jsonBody);
      //final List comments_result = list['result'];

      //final comments =  comments_result.map((e) => CommentModelResult.fromJson(e)).toList();

      final comments =
          CommentModelResult.fromJson(json.decode(response.body)).comments;
      return comments!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: list_comments,
      builder: (context, List<CommentModel> value, _) {
        return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: value.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onDoubleTap: () {
                print('removing');

                setState(() {
                  list_comments.value.removeAt(index);
                });
                // list_comments.;
                print(list_comments.value);
                print(value.length);
              },
              child: ListTile(
                title: Text(value[index].comment!),
                subtitle: Text(
                  value[index].user!.firstName!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
