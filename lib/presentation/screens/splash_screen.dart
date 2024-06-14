import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/image_resources.dart';
import 'package:ar_admin/helper/constants/screen_percentage.dart';

import 'package:ar_admin/presentation/screens/bottom_navigation_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    delayed();
    super.initState();
  }

  Future<void> delayed() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationBarScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
          color: ColorsResources.BLACK_COLOR,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                      height: mediaQuerySize.height *
                          ScreenPercentage.SCREEN_SIZE_25,
                      child: Image.asset(
                        ImageResources.APP_LOGO,
                        fit: BoxFit.cover,
                      ))),
              Text(
                'AR Tailor Admin',
                style: TextStyle(
                    letterSpacing: 2,
                    fontFamily: 'Chela Regular',
                    color: ColorsResources.WHITE_COLOR,
                    fontSize: 25.sp),
              )
            ],
          )),
    );
  }
}
