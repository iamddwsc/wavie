import 'package:flutter/material.dart';
import 'package:wavie/data/models/boxes.dart';
import '../../../common/extensions/size_extensions.dart';

import '../../../common/constants/size_constants.dart';

class MyListAppBar extends StatelessWidget {
  final String title;
  final bool pop3;
  const MyListAppBar({Key? key, this.title = 'My List', this.pop3 = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = Boxes.getIsAlwaysDown();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (box.containsKey('isAlwaysDownKey')) {
              box.delete('isAlwaysDownKey');
              box.put('isAlwaysDownKey', false);
            } else {
              box.put('isAlwaysDownKey', false);
            }
            Navigator.pop(context);
            // Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: Sizes.dimen_10.h,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: Sizes.dimen_18,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (box.containsKey('isAlwaysDownKey')) {
              box.delete('isAlwaysDownKey');
              box.put('isAlwaysDownKey', true);
            } else {
              box.put('isAlwaysDownKey', true);
            }
            Navigator.pop(context);
            Navigator.pop(context);
            pop3 ? Navigator.pop(context) : null;
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: Sizes.dimen_12.h,
          ),
        ),
      ],
    );
  }
}
