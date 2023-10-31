import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pkl_demeter_mobile/constants/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pkl_demeter_mobile/home/screens/home_screen.dart';
import 'package:pkl_demeter_mobile/constants/utils/tools.dart';
import 'package:pkl_demeter_mobile/provider/user_provider.dart';

class AuthService {
  signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final client = http.Client();
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      const loginUri = "$baseUrl/api/signin";

      http.Response response = await client.post(Uri.parse(loginUri),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(response.body);

            print(response.body);

            await prefs.setString(
                'x-auth-token', jsonDecode(response.body)['token']);
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          });
    } catch (e) {
      // showSnackBar(context, e.toString());
      AppLogger.logError("Failed to login.", e);
    }
  }
}
