import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const kTextFieldInputDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.teal, width: 1.0)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.teal, width: 3.0)));

const kDarkCoralColour = Color(0xffFF907C);
const kLightCoralColour = Color(0xffFFC4B2);
const kMediumCoralColour = Color(0xffFDAFA2);
const kAppBarColour = Color(0xff66BEB2);
const kScaffoldColour = Color(0xffFBF3EB);
const kInfoCardsColors = [
  kLightCoralColour,
  kMediumCoralColour,
  kDarkCoralColour
];
