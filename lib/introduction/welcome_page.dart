import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pkl_demeter_mobile/constants/utils/tools.dart';
import 'package:pkl_demeter_mobile/home/screens/home_screen.dart';
import 'package:pkl_demeter_mobile/home/widgets/main_button.dart';
import 'package:pkl_demeter_mobile/main.dart';
import 'package:pkl_demeter_mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider propider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(gradient: Tools.gradientColor)),
          Center(
              child: FadeInUp(
            duration: Duration(milliseconds: 2100),
            child: Image.asset("asset/images/agriculture.png",
                height: 250, fit: BoxFit.fitHeight),
          )),
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: FadeInRight(
                            duration: Duration(milliseconds: 1500),
                            child: Text("Demeter",
                                style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF063166))),
                          )),
                      const Spacer(),
                      FadeIn(
                        duration: Duration(milliseconds: 3000),
                        child: Text("Selamat Datang, ${propider.user.name}!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: const Color(0xFF063166))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: MainButton(
                                backgroundColor: Tools.primaryColor,
                                text: "Get started!",
                                onTap: () {
                                  final navigator = Navigator.of(context);
                                  navigator.pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                      (route) => false);
                                })),
                      )
                    ],
                  )))
        ]));
  }
}
