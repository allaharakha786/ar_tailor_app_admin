import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/dimentions_resources.dart';
import 'package:ar_admin/helper/utills/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonDropDownBotton extends StatelessWidget {
  void Function(String?)? onChange;
  String? value;
  CommonDropDownBotton(
      {super.key, required this.onChange, required this.value});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(DimensionsResource.RADIUS_DEFAULT),
      dropdownColor: ColorsResources.GREY_COLOR,
      value: value,
      items: [
        DropdownMenuItem(
            value: 'Pending',
            child: Text(
              'Pending',
              style: CustomTextStyles.contentTextStyle(
                  ColorsResources.WHITE_COLOR),
            )),
        DropdownMenuItem(
            value: 'Completed',
            child: Text(
              'Completed',
              style: CustomTextStyles.contentTextStyle(
                  ColorsResources.WHITE_COLOR),
            ))
      ],
      onChanged: onChange,
    );
  }
}
