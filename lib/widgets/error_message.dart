import 'package:flutter/material.dart';

void errorMessage(BuildContext context, String errorMessage) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'))
          ],
        );
      });
}
