import 'package:ar_admin/helper/constants/screen_percentage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizedBoxPadding extends StatelessWidget {
  const SizedBoxPadding({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SizedBox(
      height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_1.h,
    );
  }
}
