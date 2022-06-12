import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wavie/common/constants/api_constants.dart';
import 'package:wavie/common/extensions/size_extensions.dart';
import 'package:wavie/data/models/boxes.dart';
import 'package:wavie/data/models/user.dart';
import 'package:wavie/presentation/themes/app_colors.dart';
import 'package:wavie/presentation/themes/theme_text.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/screenutil/screenutil.dart';

import 'package:flutter/services.dart';

import '../../../di/get_it.dart';
import '../../blocs/authentication/authentication_bloc.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  File? image;
  late TextEditingController textEditingController_name;
  late TextEditingController textEditingController_email;
  var myUser = Boxes.getMyUser().get('myUser')!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController_name =
        TextEditingController(text: '${myUser.lastName} ${myUser.firstName}');
    textEditingController_email = TextEditingController(text: myUser.email);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController_name.dispose();
    textEditingController_email.dispose();
    super.dispose();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  List<String> trimName(String name) {
    List<String> z = name.split(' ');
    String first_name = z.last;
    z.removeLast();
    String last_name = z.join(' ');
    return [first_name, last_name];
  }

  Map<String, dynamic> toJson(List<String> name) => {
        'first_name': name[0],
        'last_name': name[1],
        // 'email': userName,
        // 'password': password,
      };

  @override
  Widget build(BuildContext context) {
    var myToken = Boxes.getMyToken().get('token');
    var size = MediaQuery.of(context).size;
    AuthenticationBloc authenticationBloc = getItInstance<AuthenticationBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            color: AppColor.profile_background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          margin: EdgeInsets.only(
              top: ScreenUtil.statusBarHeight + Sizes.dimen_10.h),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: Sizes.dimen_16),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Edit Profile    ',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            height: 0.75, fontWeight: FontWeight.bold),
                        //textAlign: TextAlign.end,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        List<String> name =
                            trimName(textEditingController_name.text);
                        authenticationBloc.add(UpdateUserEvent(
                            name[1], name[0], image?.path ?? '', myToken!));
                      },
                      child: Container(
                        child: Text(
                          'Done',
                          style: TextStyle(fontSize: Sizes.dimen_16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              BlocProvider.value(
                value: authenticationBloc,
                child: Container(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: size.width * 0.24,
                            height: size.width * 0.24,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.details_grey,
                                      blurRadius: 10,
                                      spreadRadius: 50,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: image != null
                                    ? Image.file(image!)
                                    : CachedNetworkImage(
                                        imageUrl: ApiConstants.BASE_SOURCE_URL +
                                            '/storage/users/' +
                                            myUser.photo!,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: GestureDetector(
                          onTap: () => pickImage(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              color: AppColor.white,
                              child: Icon(
                                Icons.edit_outlined,
                                size: Sizes.dimen_28,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _buildTextField(
                  context, 'Name', '${myUser.lastName} ${myUser.firstName}',
                  controller: textEditingController_name),
              _buildTextField(context, 'Email', myUser.email!,
                  enable: false, controller: textEditingController_email),
              // _buildTextField(context, 'Phone', myUser.!),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTextField(BuildContext context, String label, String value,
      {bool enable = true, TextEditingController? controller}) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 15.0),
      child: TextFormField(
        enabled: enable,
        controller: controller,
        style: TextStyle(
            fontSize: Sizes.dimen_18,
            color: enable ? AppColor.white : AppColor.white.withOpacity(0.2)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: enable ? AppColor.white : AppColor.white.withOpacity(0.2)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: AppColor.white.withOpacity(0.3), width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.white.withOpacity(0.8), width: 1.9),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: AppColor.white.withOpacity(0.2), width: 2.0),
          ),
        ),
        autocorrect: false,

        //initialValue: value,
      ),
    );
  }
}
