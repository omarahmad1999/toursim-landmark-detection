import 'package:flutter/material.dart';
import 'package:wander2/screens/display_picture_screen.dart';
import 'package:wander2/screens/welcome_screen.dart';
import 'package:wander2/screens/registration_screen.dart';
import 'package:wander2/screens/login_screen.dart';
import 'package:wander2/screens/detection_screen.dart';
import 'package:camera/camera.dart';
import 'package:wander2/screens/take_picture_screen.dart';
import 'package:wander2/screens/scratch_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wander2/screens/landmark_information_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  // final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.

  // final firstCamera = cameras.first;

  runApp(MyApp(
      // appCamera: firstCamera,
      ));
}

String imgPath;

class MyApp extends StatelessWidget {
  // final appCamera;

  // MyApp({this.appCamera});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error connecting to firebase');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              initialRoute: DetectionScreen.id,
              routes: {
                WelcomeScreen.id: (context) => WelcomeScreen(),
                RegistrationScreen.id: (context) => RegistrationScreen(),
                LoginScreen.id: (context) => LoginScreen(),
                DetectionScreen.id: (context) => DetectionScreen(),
                StaticImage.id: (context) => StaticImage(),
                // LandmarkInformationScreen.id: (context) =>
                //     LandmarkInformationScreen(),
                // TakePictureScreen.id: (context) => TakePictureScreen(
                //       camera: appCamera,
                //       imgPathCallBack: (String path) {
                //         imgPath = path;
                //       },
                //     ),
                DisplayPictureScreen.id: (context) => DisplayPictureScreen(
                      imagePath: imgPath,
                    )
              },
            );
          }
          return CircularProgressIndicator();
        });
  }
}
