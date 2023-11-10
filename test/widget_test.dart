import 'package:flutter/material.dart';
import 'package:pkl_demeter_mobile/home/widgets/dialog_box.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
            onPressed: () {
              DialogBox.dialogInfo(context, "Cool!", () {}, );
            },
            child: Text("Test")));
  }
}
