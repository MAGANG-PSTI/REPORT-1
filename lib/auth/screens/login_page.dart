import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:pkl_demeter_mobile/auth/services/auth_service.dart';
import 'package:pkl_demeter_mobile/constants/utils/logger.dart';
import 'package:pkl_demeter_mobile/constants/utils/tools.dart';
import 'package:pkl_demeter_mobile/home/widgets/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String screenName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();

  void signInUser(BuildContext context) async {
    try {
      await authService.signInUser(
          context: context,
          email: emailController.text,
          password: passwordController.text);
    } catch (e) {
      AppLogger.logError("Failed to login:", e);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: SingleChildScrollView(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/login_background.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: FadeInUp(
                        duration: const Duration(seconds: 1),
                        child: Container(
                          decoration: const  BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('asset/images/light-1.png'))),
                        )),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: Container(
                          decoration: const BoxDecoration(
                              image:  DecorationImage(
                                  image:
                                      AssetImage('asset/images/light-2.png'))),
                        )),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: FadeInUp(
                        duration:const Duration(milliseconds: 1300),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('asset/images/clock.png'))),
                        )),
                  ),
                  Positioned(
                    child: FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromRGBO(143, 251, 148, 1)),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 251, 179, 0.2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromRGBO(
                                              143, 251, 143, 1)))),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email),
                                    border: InputBorder.none,
                                    hintText: "Email ",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700])),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700])),
                              ),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(height: 10),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(143, 251, 143, 1),
                              Color.fromRGBO(143, 251, 152, 0.6),
                            ])),
                        child: Center(
                            child: MainButton(
                                backgroundColor: Tools.primaryColor,
                                text: "SIGN UP",
                                onTap: () {
                                  signInUser(context);
                                })),
                      )),
                 const  SizedBox(
                    height: 70,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 2000),
                      child: const Text(
                        "Contributed by UBL.",
                        style:
                            TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
