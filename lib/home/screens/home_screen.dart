import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pkl_demeter_mobile/auth/screens/login_page.dart';
import 'package:pkl_demeter_mobile/auth/services/auth_service.dart';
import 'package:pkl_demeter_mobile/constants/utils/tools.dart';
import 'package:pkl_demeter_mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    UserProvider propider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
        // ignore: unnecessary_null_comparison
        body: propider != null
            ? SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${propider.user.name}'s",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text("Homepage",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black))
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        authService.signOut(context);
                                      },
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Tools.primaryColor
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: const Center(
                                              child: Icon(
                                                  LineIcons.alternateSignOut))))
                                ],
                              ),
                              const SizedBox(height: 35),
                              Container(
                                  width: double.infinity,
                                  height: 145,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 0,
                                            spreadRadius: 0,
                                            offset: Offset(0, 0))
                                      ],
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromARGB(207, 10, 255, 71)))
                            ]))),
              )
            : const LoginPage());
  }
}
