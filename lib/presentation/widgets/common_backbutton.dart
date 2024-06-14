import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/presentation/widgets/decorated_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/constants/dimentions_resources.dart';
import '../../helper/constants/screen_percentage.dart';

// ignore: must_be_immutable
class CommonBackButton extends StatelessWidget {
  void Function()? onTap;
  CommonBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return DecoratedContainer(
      height: ScreenPercentage.SCREEN_SIZE_6,
      width: ScreenPercentage.SCREEN_SIZE_15,
      child: IconButton(
        onPressed: onTap,
        icon: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
            child: Icon(
              size: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_4.h,
              Icons.arrow_back_ios,
              color: ColorsResources.AMBER_ACCENT,
            ),
          ),
        ),
      ),
    );
  }
}
