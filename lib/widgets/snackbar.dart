import 'package:flutter/material.dart';

showSnackbar(message, context) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
