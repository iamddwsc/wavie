import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wavie/data/core/api_constants.dart';
import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/data/repositories/movie_repository_impl.dart';
import 'package:wavie/domain/entities/app_error.dart';
import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/no_params.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';
import 'package:wavie/domain/usecases/get_trending.dart';
import 'package:wavie/presentation/themes/app_colors.dart';
import 'package:wavie/presentation/wavie_app.dart';
import 'package:wavie/common/appcolors.dart' as appcolors;
import 'package:wavie/data/data_sources/movie_remote_data_source.dart';
import 'package:wavie/data/data_sources/movie_remote_data_source_impl.dart';

import '../common/screenutil/screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textFieldFocusNode = FocusNode();
  final textController = TextEditingController();
  bool _obscureText = true;
  bool _passwordChanged = false;

  String _password = "";

  void _toggleObscured() {
    setState(() {
      _obscureText = !_obscureText;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(builder: (context) {
          return Container(
            color: appcolors.background,
            // height: MediaQuery.of(context).size.height,
            // decoration: BoxDecoration(
            //     color: Colors.black,
            //     image: DecorationImage(
            //         opacity: 0.75,
            //         fit: BoxFit.cover,
            //         image: AssetImage('assets/images/logo2.png'))),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => {},
                            icon: Icon(
                              Icons.navigate_before,
                              color: Colors.white,
                            )),
                        Expanded(
                          child: Container(
                            width: 32.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                                //color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: const AssetImage(
                                      'assets/images/logo.png',
                                    ))),
                          ),
                        ),
                        TextButton(
                            onPressed: () => {},
                            child: Text(
                              "Help",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16.0),
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            style: TextStyle(color: AppColor.background),
                            decoration: InputDecoration(
                                hintText: "Email or phone number",
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(20.0)),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: AppColor.background),
                            controller: textController,
                            textInputAction: TextInputAction.go,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            focusNode: textFieldFocusNode,
                            onChanged: (val) => {
                              setState(() {
                                if (val.length > 0) {
                                  _passwordChanged = true;
                                } else {
                                  _passwordChanged = false;
                                }
                              })
                            },
                            validator: (val) =>
                                val!.length < 6 ? 'Password too short.' : null,
                            onSaved: (val) => _password = val!,
                            decoration: InputDecoration(
                              iconColor: AppColor.background,
                              floatingLabelBehavior: FloatingLabelBehavior
                                  .never, //Hides label on focus or if filled
                              hintText: "Password",
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(20.0),
                              suffixIcon: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15.0, 5.0, 0),
                                child: GestureDetector(
                                    onTap: _toggleObscured,
                                    child: Text(
                                      _obscureText ? "SHOW" : "HIDE",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: AppColor.background),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            height: 50.0,
                            width: double.infinity,
                            //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  side: BorderSide(color: Colors.black),
                                  splashFactory: NoSplash.splashFactory,
                                  enableFeedback: false,
                                  primary: _passwordChanged
                                      ? appcolors.button
                                      : appcolors.background),
                              child: Text("Login"),
                              onPressed: () => {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => const WavieApp()))
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 50.0,
                            width: double.infinity,
                            //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: appcolors.background,
                                  splashFactory: NoSplash.splashFactory,
                                  enableFeedback: false),
                              child: Text("Recovery password"),
                              onPressed: () => {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          );
        }),
      ),
    );
  }
}
