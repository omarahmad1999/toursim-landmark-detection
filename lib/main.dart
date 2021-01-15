import 'package:flutter/material.dart';
import 'package:wander2/screens/welcome_screen.dart';
import 'package:wander2/screens/registration_screen.dart';
import 'package:wander2/screens/login_screen.dart';
import 'package:wander2/screens/detection_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

String imgPath;

class MyApp extends StatelessWidget {
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
              initialRoute: WelcomeScreen.id,
              routes: {
                WelcomeScreen.id: (context) => WelcomeScreen(),
                RegistrationScreen.id: (context) => RegistrationScreen(),
                LoginScreen.id: (context) => LoginScreen(),
                DetectionScreen.id: (context) => DetectionScreen(),
              },
            );
          }
          return CircularProgressIndicator();
        });
  }
}
