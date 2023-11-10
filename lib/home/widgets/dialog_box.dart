import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DialogBox {
  static dialogInfo(
    BuildContext context,
    String message,
    VoidCallback onTap,
  ) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      btnOkOnPress: onTap,
      dialogType: DialogType.info,
      title: "Information",
      desc: message,
    )..show();
  }

  static dialogError(BuildContext context, String message, VoidCallback onTap) {
    return AwesomeDialog(context: context, animType: AnimType.topSlide, desc: message, btnOkOnPress: onTap, title: "Error!", dialogType: DialogType.error, btnCancelOnPress: onTap)..show();
  }
  static dialogWarning(BuildContext context, String message, VoidCallback onTap, VoidCallback onTapCancel) {
    return AwesomeDialog(context: context, title: "Warning", btnOkOnPress: onTap,animType: AnimType.scale, desc: message, dialogType: DialogType.warning, btnCancelOnPress: onTapCancel)..show();  }
  static dialogSuccess(BuildContext context, String message, VoidCallback onTap) {
    return AwesomeDialog(context: context, title: "Succesful!", btnOkOnPress: onTap,animType: AnimType.scale, desc: message, dialogType: DialogType.success, btnCancelOnPress: onTap)..show();
  }
}
