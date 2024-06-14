import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/dimentions_resources.dart';
import 'package:ar_admin/helper/constants/screen_percentage.dart';
import 'package:ar_admin/helper/utills/text_styles.dart';
import 'package:flutter/material.dart';

import 'loading_indicator.dart';

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  String text;
  void Function()? onTap;
  double width;
  bool isloading;
  CommonButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.width,
      required this.isloading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: DimensionsResource.PADDING_SIZE_DEFAULT),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    ColorsResources.BLACK_COLOR,
                    ColorsResources.BLACK_12
                  ]),
              boxShadow: [
                BoxShadow(
                    color: ColorsResources.GREY_COLOR,
                    spreadRadius: 1,
                    blurRadius: 4.5,
                    offset: const Offset(0, 0))
              ],
              borderRadius:
                  BorderRadius.circular(DimensionsResource.RADIUS_EXTRA_LARGE)),
          height: MediaQuery.of(context).size.height *
              ScreenPercentage.SCREEN_SIZE_6,
          width: width,
          child: Center(
              child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(
                  DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
              child: isloading
                  ? const CommonLoadingIndicator()
                  : Text(text,
                      style: CustomTextStyles.elevatedTextButtonStyle(
                          ColorsResources.WHITE_COLOR)),
            ),
          )),
        ),
      ),
    );
  }
}
