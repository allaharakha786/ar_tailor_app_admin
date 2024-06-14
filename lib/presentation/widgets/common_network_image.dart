import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/string_resources.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonNetworkImage extends StatelessWidget {
  String imagePath;
  CommonNetworkImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            color: ColorsResources.AMBER_ACCENT,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(child: Text(StringResources.ERROR_MESSAGE));
      },
    );
  }
}
