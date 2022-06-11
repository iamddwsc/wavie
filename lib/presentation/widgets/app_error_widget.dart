import 'package:flutter/material.dart';
import 'package:wavie/domain/entities/app_error.dart';
import 'package:wavie/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final VoidCallback onPressed;

  const AppErrorWidget(
      {Key? key, required this.errorType, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(errorType == AppErrorType.networkError
            ? 'Check your network connection'
            : 'Something Went Wrong'),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('Retry'),
              onPressed: onPressed,
            ),
          ],
        ),
      ],
    );
  }
}
