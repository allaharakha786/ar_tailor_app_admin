import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/utills/text_styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AwesomeDialogAlert {
  static showDialogAlert(BuildContext context, DialogType type, String title,
      String desription, void Function()? onTap) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: title,
      desc: desription,
      descTextStyle:
          CustomTextStyles.contentTextStyle(ColorsResources.BLACK_COLOR),
      buttonsTextStyle: TextStyle(color: ColorsResources.BLACK_COLOR),
      btnOkOnPress: onTap,
    ).show();
  }
}
