import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'display_picture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  static final String id = 'take_picture_screen';
  final Function imgPathCallBack;
  final CameraDescription camera;
  TakePictureScreen({@required this.camera, @required this.imgPathCallBack});
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            width: 500,
            height: 500,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          RaisedButton(
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final path = join(
                  // Store the picture in the temp directory.
                  // Find the temp directory using the `path_provider` plugin.
                  (await getTemporaryDirectory()).path,
                  '${DateTime.now()}.png',
                );
                await _controller.takePicture(path);
                widget.imgPathCallBack(path);
                Navigator.pushNamed(context, DisplayPictureScreen.id);
              } catch (e) {
                print(e);
              }
            },
            child: Icon(Icons.camera),
          )
        ],
      ),
    ));
  }
}
