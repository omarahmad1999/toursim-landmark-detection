import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  static final String id = 'display_picture_screen';
  final String imagePath;
  DisplayPictureScreen({this.imagePath});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Display_picture'),
      ),
      body: Image.file(File(imagePath)),
    ));
  }
}
