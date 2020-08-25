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
