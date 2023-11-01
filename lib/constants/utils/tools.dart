import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://192.168.7.105:3000';

class Tools {
  static Color primaryColor = Color.fromARGB(255, 0, 216, 36);
  static Color secondaryColor = Colors.greenAccent;

  static LinearGradient gradientColor = const LinearGradient(
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color.fromARGB(255, 72, 218, 96),
        Color.fromARGB(255, 157, 236, 181)
      ]);
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case (200):
      onSuccess();

      break;
    case (400):
      showSnackBar(context, jsonDecode(response.body)['msg']);

      break;
    case (500):
      showSnackBar(context, jsonDecode(response.body)['error']);

      break;

    default:
      showSnackBar(context, response.body);
      break;
  }
}
