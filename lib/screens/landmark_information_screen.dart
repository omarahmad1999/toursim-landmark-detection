import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wander2/constants.dart';
import 'package:wander2/landmark_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var landmarkData;

class LandmarkInformationScreen extends StatelessWidget {
  final String predictedLabel;
  static final String id = 'landmark_information_screen';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LandmarkInformationScreen({this.predictedLabel});

  Future<List<Widget>> createInfoCards() async {
    List<Widget> containers = [];
    int counter = 1;
    var landmarkData = await getData();
    for (var dataPiece in landmarkData) {
      containers.add(InfoCard(
          cardNumber: counter,
          colour: kInfoCardsColors[(counter - 1) % 3],
          info: dataPiece));
      counter += 1;
    }
    return containers;
  }

  Future<List> getData() async {
    try {
      var information = await _firestore
          .collection('landmark_information')
          .where('landmark_name', isEqualTo: predictedLabel)
          .get();
      for (var landmark in information.docs) {
        landmarkData = landmark.data()['landmark_data'];
      }
      return landmarkData;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffoldColour,
      appBar: AppBar(
        title: Text('Landmark Information'),
        backgroundColor: kAppBarColour,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: kLightCoralColour, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              predictedLabel.toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          FutureBuilder(
              future: createInfoCards(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return snapshot.hasData
                    ? Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return snapshot.data[index];
                        },
                        itemHeight: size.width,
                        itemWidth: size.width,
                        itemCount: snapshot.data.length,
                        layout: SwiperLayout.TINDER,
                        pagination:
                            SwiperPagination(alignment: Alignment.bottomCenter),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              })
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final Color colour;
  final String info;
  final int cardNumber;
  InfoCard(
      {@required this.colour, @required this.info, @required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minWidth: size.width, minHeight: size.width),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: colour,
          ),
          child: Column(
            children: [
              Text(
                '$cardNumber',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  info,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
