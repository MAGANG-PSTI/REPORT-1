import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final String? iconPath;

  const MainButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.backgroundColor,
      this.textColor,
      this.iconPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 75,
          width: double.infinity,
          decoration: BoxDecoration(
              color: backgroundColor ?? Color(0xFF063166),
              borderRadius: BorderRadius.circular(28)),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconPath == null
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Image(image: AssetImage(iconPath!), height: 25),
                    ),
              Text(text,
                  style: GoogleFonts.poppins(
                      color: textColor ?? Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ],
          )),
        ));
  }
}
