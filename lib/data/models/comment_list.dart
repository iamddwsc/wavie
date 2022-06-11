import 'package:flutter/cupertino.dart';

import 'comment_model.dart';

class CommentList extends ChangeNotifier {
  List<CommentModel> _comments = [];

  List<CommentModel> get comments => _comments;
}
