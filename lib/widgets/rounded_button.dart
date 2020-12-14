import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class RoundedButton extends StatelessWidget {
  final Color colour;
  final String title;
  final Function onPressed;
  RoundedButton(
      {@required this.colour, @required this.title, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: onPressed),
      ),
    );
  }
}
