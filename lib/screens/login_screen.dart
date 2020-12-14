import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:wander2/constants.dart';
import 'package:wander2/widgets/rounded_button.dart';
import 'detection_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wander2/widgets/error_message.dart' as error;

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColour,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Hero(
                tag: 'wanderer',
                child: Image.asset(
                  'assets/wanderer.png',
                  height: 220,
                  width: 110,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'Enter your email'),
              onChanged: (newText) {
                email = newText;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'Enter your password'),
              onChanged: (newText) {
                password = newText;
              },
            ),
            SizedBox(
              height: 8,
            ),
            RoundedButton(
                colour: kLightCoralColour,
                title: 'Login',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    UserCredential loggedinUser =
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                    if (loggedinUser != null) {
                      Navigator.pushNamed(context, DetectionScreen.id);
                    }
                  } on FirebaseAuthException catch (e) {
                    error.errorMessage(context, e.message);
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  } finally {
                    setState(() {
                      showSpinner = false;
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
