import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:wander2/constants.dart';
import 'package:wander2/widgets/rounded_button.dart';
import 'detection_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wander2/widgets/error_message.dart' as error;

class RegistrationScreen extends StatefulWidget {
  static final String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
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
              height: 8,
            ),
            TextField(
              textAlign: TextAlign.center,
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
                colour: kDarkCoralColour,
                title: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final userCredential =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                    if (userCredential != null) {
                      Navigator.pushNamed(context, DetectionScreen.id);
                    }
                  } on FirebaseAuthException catch (e) {
                    error.errorMessage(context, e.message);
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
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
