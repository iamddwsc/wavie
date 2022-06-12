import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wavie/common/constants/size_constants.dart';
import 'package:wavie/data/models/comment_model.dart';
import 'package:wavie/presentation/themes/app_colors.dart';

class CommentOptionPanel extends StatelessWidget {
  final PanelController panelController;
  final CommentModel comment;
  const CommentOptionPanel(
      {Key? key, required this.panelController, required this.comment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            child: _buildOption('Phản hồi', () {}),
          )
        ],
      ),
    );
  }

  Widget _buildOption(String text, VoidCallback onTap) {
    return GestureDetector(
      child: Text(
        text,
        style: TextStyle(
          color: AppColor.white,
          fontSize: Sizes.dimen_18,
        ),
      ),
    );
  }
}
