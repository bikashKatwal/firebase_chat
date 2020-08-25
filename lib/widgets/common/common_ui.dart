import 'package:flutter/material.dart';

void showSnackBar(
    GlobalKey<ScaffoldState> globalScaffoldKey, Text message, Color color) {
  var currentScaffold = globalScaffoldKey.currentState;
  //if there is any snackbar visible
  currentScaffold.hideCurrentSnackBar();
  currentScaffold.showSnackBar(SnackBar(
    content: message,
    backgroundColor: color ?? Colors.black,
  ));
}

Future<void> showChoiceDialog(BuildContext context,
    {Function openGallary, Function openCamera}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Make a choice"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  onTap: () {
                    openGallary();
                    Navigator.of(context).pop();
                  },
                  child: Text('Gallery'),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                ),
                GestureDetector(
                  onTap: () {
                    openCamera();
                    Navigator.of(context).pop();
                  },
                  child: Text('Camera'),
                )
              ],
            ),
          ),
        );
      });
}
