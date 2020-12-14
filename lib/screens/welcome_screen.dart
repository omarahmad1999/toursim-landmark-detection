import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wander2/widgets/rounded_button.dart';
import 'package:wander2/screens/login_screen.dart';
import 'package:wander2/screens/registration_screen.dart';
import 'package:wander2/constants.dart';

class WelcomeScreen extends StatelessWidget {
  static final String id = 'welcome_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kScaffoldColour,
        appBar: AppBar(
          backgroundColor: kAppBarColour,
          title: Center(
            child: Text(
              'Wander',
              style: TextStyle(fontFamily: 'Flavors', fontSize: 50.0),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 70.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'wanderer',
                child: Image.asset(
                  'assets/wanderer.png',
                  height: 220,
                  width: 110,
                  color: Colors.black,
                ),
              ),
              RoundedButton(
                colour: kLightCoralColour,
                title: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              SizedBox(
                height: 0.0,
                width: double.infinity,
              ),
              RoundedButton(
                colour: kDarkCoralColour,
                title: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
