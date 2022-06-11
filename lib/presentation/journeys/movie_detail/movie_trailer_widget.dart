import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class MovieTrailerWidget extends StatefulWidget {
  final ChewieController chewieController;
  const MovieTrailerWidget({Key? key, required this.chewieController})
      : super(key: key);

  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  @override
  Widget build(BuildContext context) {
    //widget.chewieController.aspectRatio = 3 / 2;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 275.0,
          child: Padding(
              padding: EdgeInsets.all(0.0),
              child: Chewie(controller: widget.chewieController)),
        ),
      ),
    );
  }
}
