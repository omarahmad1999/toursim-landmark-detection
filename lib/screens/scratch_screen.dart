import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class StaticImage extends StatefulWidget {
  static final String id = 'scratch_screen';

  @override
  _StaticImageState createState() => _StaticImageState();
}

class _StaticImageState extends State<StaticImage> {
  File _image;
  List _recognitions;
  bool _busy;
  double _imageWidth, _imageHeight;

  final picker = ImagePicker();

  // this function loads the model
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/ssd_mobilenet.tflite",
      labels: "assets/labelmap.txt",
    );
  }

  // this function detects the objects on the image
  detectObject(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path, // required
        model: "SSDMobileNet",
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4, // defaults to 0.1
        numResultsPerClass: 10, // defaults to 5
        asynch: true // defaults to true
        );
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));
    setState(() {
      _recognitions = recognitions;
    });
  }

  @override
  void initState() {
    super.initState();
    _busy = true;
    loadTfModel().then((val) {
      {
        setState(() {
          _busy = false;
        });
      }
    });
  }

  // display the bounding boxes over the detected objects
  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];
    print('screen width${screen.width}');
    print('screen height${screen.height}');
    double factorX = _imageWidth / (_imageWidth / screen.width);
    double factorY = _imageHeight / (_imageHeight / (screen.height * (5 / 7)));
    print(_imageHeight);
    print('factor y ${factorY}');
    Color blue = Colors.blue;
    for (var x in _recognitions) {
      print(x);
    }
    return _recognitions.map((re) {
      return Container(
        child: Positioned(
            left: re["rect"]["x"] * factorX,
            top: re["rect"]["y"] * factorY,
            width: re["rect"]["w"] * factorX,
            height: re["rect"]["h"] * factorY,
            child: ((re["confidenceInClass"] > 0.50))
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: blue,
                      width: 3,
                    )),
                    child: Text(
                      "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                        background: Paint()..color = blue,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  )
                : Container()),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      // using ternary operator
      child: _image == null
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Please Select an Image"),
                ],
              ),
            )
          : // if not null then
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                border: Border.all(width: 5),
              ),
              child: Image.file(
                _image,
                width: size.width,
                height: size.height * (5 / 7),
              )),
    ));

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Touristic Landmark Detector"),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "Fltbtn2",
            child: Icon(Icons.camera_alt),
            onPressed: getImageFromCamera,
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: "Fltbtn1",
            child: Icon(Icons.photo),
            onPressed: getImageFromGallery,
          ),
        ],
      ),
      body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Stack(
                  children: stackChildren,
                  overflow: Overflow.clip,
                ),
              ),
              _image != null
                  ? Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              _recognitions[0]['detectedClass'],
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          RaisedButton(
                            elevation: 5.0,
                            onPressed: () {},
                            child: Text('History'),
                          )
                        ],
                      ),
                    )
                  : Container()
            ],
          )),
    );
  }

  // gets image from camera and runs detectObject
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image);
  }

  // gets image from gallery and runs detectObject
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });

    detectObject(_image);
  }
}
