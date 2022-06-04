import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wavie/common/appcolors.dart' as appcolors;

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: appcolors.background,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: appcolors.button_background,
                      ),
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(7.0),
                      //alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: (() {
                          Navigator.of(context).pop();
                        }),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image.asset(
                            'assets/icons/close.png',
                            color: Colors.white,
                            // height: 24.0,
                            // width: 24.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          //margin: EdgeInsets.only(right: 20.0), width: 32.0,
                          height: 80.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: Image.asset(
                              'assets/images/avatar.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                          child: Text(
                            'Đức',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: appcolors.white,
                                decoration: TextDecoration.none),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            print('edit');
                          }),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 24.0,
                                height: 42.0,
                                padding: EdgeInsets.all(2.0),
                                margin: EdgeInsets.only(right: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.asset(
                                    'assets/icons/edit.png',
                                    color: Colors.white,
                                    // height: 22.0,
                                    // width: 42.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Text(
                                'Manage Profiles',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: appcolors.white,
                                    decoration: TextDecoration.none),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                option('Notifications', 'assets/icons/notification.png'),
              ],
            )));
  }

  Widget option(String name, String icon_path) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(color: appcolors.button_background),
      child: Row(
        children: [
          Image.asset(
            icon_path,
            width: 24.0,
            height: 24.0,
            color: appcolors.white,
            fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: appcolors.white,
                  decoration: TextDecoration.none),
            ),
          ),
          Expanded(child: Divider()),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            padding: EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/icons/right-arrow.png',
              width: 14.0,
              height: 14.0,
              color: appcolors.white,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
