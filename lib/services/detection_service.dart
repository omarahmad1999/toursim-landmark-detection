import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:wander2/widgets/error_message.dart' as error;

class DetectionService {
  static double _threshHold = 0;
  static List _recognitions;
  static double _imageWidth, _imageHeight;
  static String _predictedLabel;
  static double max = -1;
  static BuildContext context;
  static Future<void> loadModel() async {
    String res = await Tflite.loadModel(
        model: "assets/landmark_object_detection_model_0.5.tflite",
        labels: "assets/landmark_label_map.pbtxt",
        numThreads: 1,
        // defaults to 1
        isAsset: true,
        // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  static Future<List> objectDetection(File image) async {
    try {
      var recognitions = await Tflite.detectObjectOnImage(
          path: image.path,
          // required
          model: "SSDMobileNet",
          imageMean: 127.5,
          imageStd: 127.5,
          threshold: _threshHold,
          // defaults to 0.1
          numResultsPerClass: 2,
          // defaults to 5
          asynch: true // defaults to true
          );
      FileImage(image)
          .resolve(ImageConfiguration())
          .addListener((ImageStreamListener((ImageInfo info, bool _) {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          })));

      _recognitions = recognitions;
      print(_recognitions);
      return _recognitions;
    } catch (e) {
      print('unable to use inference');
      print('error message: $e');
    }
  }

  static String predictedLabel(List recognitions) {
    _predictedLabel = null;

    for (var recognition in recognitions) {
      if (recognition['detectedClass'] == 'hofborg_palace') {
        recognition['detectedClass'] = 'hofburg_palace';
      }
      if (recognition['detectedClass'] == 'castle_nuovo') {
        recognition['detectedClass'] = 'castel_nuovo';
      }
      if (recognition['confidenceInClass'] > _threshHold &&
          recognition['confidenceInClass'] > max) {
        _predictedLabel = recognition['detectedClass'];
        max = recognition['confidenceInClass'];
      }
    }
    max = -1;

    return _predictedLabel;
  }

  static List<Widget> renderBoxes(Size Screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == null || _imageWidth == null) return [];
    double scaleX = _imageWidth / (_imageWidth / Screen.width);
    double scaleY = _imageHeight / (_imageHeight / (Screen.height * (5 / 7)));
    return _recognitions.map((re) {
      return Container(
        child: Positioned(
          left: re['rect']['x'] * scaleX,
          top: re['rect']['y'] * scaleY,
          width: re['rect']['w'] * scaleX,
          height: re['rect']['h'] * scaleY,
          child: (re["confidenceInClass"] > _threshHold)
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                  child: Text(
                    '${re["detectedClass"]}  ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                        backgroundColor: Colors.blue,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                )
              : Container(),
        ),
      );
    }).toList();
  }
}
