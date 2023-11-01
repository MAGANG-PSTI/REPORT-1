// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pkl_demeter_mobile/auth/screens/login_page.dart';
import 'package:pkl_demeter_mobile/introduction/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:pkl_demeter_mobile/constants/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

            AppLogger.logInfo(response.body);

            await prefs.setString(
                'x-auth-token', jsonDecode(response.body)['token']);
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomePage()),
                (route) => false);
          });
    } catch (e) {
      // showSnackBar(context, e.toString());
      AppLogger.logError("Failed to login.", e);
    }
  }

  void signOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("x-auth-token");
      final navigator = Navigator.of(context);

      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    } catch (e) {
      AppLogger.logError("Failed to sign-out", e);
    }
  }
}
