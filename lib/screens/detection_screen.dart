import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:wander2/constants.dart';
import 'package:wander2/services/detection_service.dart';
import 'package:wander2/widgets/rounded_button.dart';
import 'landmark_information_screen.dart';
import 'package:wander2/widgets/error_message.dart' as error;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wander2/landmark_database.dart';

class DetectionScreen extends StatefulWidget {
  static final String id = 'detection_screen';

  @override
  _DetectionScreenState createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  File _image;
  List _recognitions;
  bool _busy = false;
  String _predictedLabel;
  final _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    _busy = true;
    super.initState();
    DetectionService.loadModel().then((value) {
      setState(() {
        _busy = false;
      });
    }).catchError((err) {
      error.errorMessage(context, 'Failed To Load Model');
      _busy = false;
    });
  }

  void updateUI(File image) async {
    _recognitions = await DetectionService.objectDetection(image);
    setState(() {
      _predictedLabel = DetectionService.predictedLabel(_recognitions);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];
    _image != null
        ? stackChildren.add(
            Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(width: 5, color: Colors.black),
                ),
                child: Image.file(
                  _image,
                  width: size.width,
                  height: size.height * (5 / 7),
                )),
          )
        : stackChildren.add(Center(
            child: Container(
              child: Text('Select an Image'),
            ),
          ));
    if (_image != null) {
      stackChildren.addAll(DetectionService.renderBoxes(size));
    }
    if (_busy) {
      stackChildren.add(
        Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: kScaffoldColour,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        backgroundColor: kAppBarColour,
        title: Text(
          'Landmark Detection',
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Stack(
                children: stackChildren,
              ),
            ),
            Expanded(
                flex: 4,
                child: _predictedLabel != null
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: kLightCoralColour, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              _predictedLabel.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          _predictedLabel != 'Unknown Landmark'
                              ? RoundedButton(
                                  colour: kDarkCoralColour,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LandmarkInformationScreen(
                                                  predictedLabel:
                                                      _predictedLabel,
                                                )));
                                  },
                                  title: 'Historical Information')
                              : Container(),
                        ],
                      )
                    : Column())
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Color(0xffB2EEE6),
            heroTag: 'floatButton1',
            onPressed: getImageFromGallery,
            child: Icon(
              Icons.photo,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Color(0xff8AD6CC),
            heroTag: 'floatButton2',
            onPressed: getImageFromCamera,
            child: Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  getImageFromGallery() async {
    var pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      return null;
    }
    updateUI(_image);
  }

  getImageFromCamera() async {
    var pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      return null;
    }
    updateUI(_image);
  }
}
