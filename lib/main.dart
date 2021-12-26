// ignore_for_file: use_key_in_widget_constructors, unused_import
import 'package:flutter/material.dart';
import 'elements/stream.dart';
import 'elements/controls.dart';

void main() => runApp(LineFollowerApp());

class LineFollowerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A Simple Linefollower',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff084B83),
          title: const Text('LineFollower', style: TextStyle(fontSize: 28)),
        ),
        body: const Controls(),
      ),
    );
  }
}
