// ignore_for_file: sized_box_for_whitespace
import 'dart:async';
import 'package:flutter/material.dart';

class VideoStream extends StatefulWidget {
  const VideoStream({Key? key}) : super(key: key);

  @override
  _VideoStreamState createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  int counter = 0;
  String url = "http://192.168.1.26:8080/video_stream";
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), updateURL);
  }

  void updateURL(Timer timer) {
    setState(() {
      imageCache?.clear();
      url = "http://192.168.1.26:8080/video_stream?ignore=$counter";
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Image.network(
        url,
        gaplessPlayback: true,
      ),
    );
  }
}
