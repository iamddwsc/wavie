import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:wavie/common/constants/api_constants.dart';
import 'package:wavie/common/constants/route_constants.dart';
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
import 'package:wavie/presentation/themes/theme_text.dart';

import '../common/screenutil/screenutil.dart';
import '../di/get_it.dart';
import '../presentation/blocs/authentication/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textFieldFocusNode = FocusNode();
  late TextEditingController _usernameController, _passwordController;
  bool _obscureText = true;
  bool _passwordChanged = false;
  bool _enableSignIn = false;
  AuthenticationBloc? authenticationBloc;
  String _password = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationBloc = getItInstance<AuthenticationBloc>();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _usernameController.addListener(() {
      setState(() {
        _enableSignIn = _usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _enableSignIn = _usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    authenticationBloc?.close();

    super.dispose();
  }

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
    return BlocProvider<AuthenticationBloc>.value(
      value: authenticationBloc!,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (context) {
            return Container(
              color: appcolors.background,
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
                              controller: _usernameController,
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
                              controller: _passwordController,
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
                              validator: (val) => val!.length < 6
                                  ? 'Password too short.'
                                  : null,
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
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 15.0, 10.0, 0),
                                  child: GestureDetector(
                                      onTap: _toggleObscured,
                                      child: Text(
                                        _obscureText ? "SHOW" : "HIDE",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColor.background),
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            BlocConsumer<AuthenticationBloc,
                                AuthenticationState>(
                              buildWhen: (previous, current) =>
                                  current is SignInError,
                              builder: (context, state) {
                                if (state is SignInError) {
                                  return Text(
                                    state.message,
                                    style: Theme.of(context)
                                        .textTheme
                                        .orangeSubtitle1,
                                  );
                                }
                                return SizedBox.shrink();
                              },
                              listenWhen: (previous, current) =>
                                  (current is SignInSuccess),
                              listener: (context, state) {
                                Navigator.of(context)
                                    .pushReplacementNamed(RouteList.home);
                              },
                            ),
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
                                      primary: _enableSignIn
                                          ? appcolors.button
                                          : appcolors.background),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(color: AppColor.white),
                                  ),
                                  onPressed: _enableSignIn
                                      ? () {
                                          authenticationBloc!.add(SignInEvent(
                                              _usernameController.text,
                                              _passwordController.text));
                                        }
                                      : null),
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
      ),
    );
  }
}
