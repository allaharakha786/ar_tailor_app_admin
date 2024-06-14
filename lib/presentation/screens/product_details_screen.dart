import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/dimentions_resources.dart';
import 'package:ar_admin/helper/constants/screen_percentage.dart';
import 'package:ar_admin/helper/constants/string_resources.dart';
import 'package:ar_admin/helper/utills/text_styles.dart';
import 'package:ar_admin/presentation/screens/bottom_navigation_bar_screen.dart';
import 'package:ar_admin/presentation/screens/update_product_screen.dart';
import 'package:ar_admin/presentation/widgets/common_backbutton.dart';
import 'package:ar_admin/presentation/widgets/common_network_image.dart';
import 'package:ar_admin/presentation/widgets/sizedbox_padding.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  String imageUrl;
  String title;
  String details;
  String price;
  String catagory;
  dynamic indexId;
  String collection;

  ProductDetailsScreen(
      {super.key,
      required this.imageUrl,
      required this.details,
      required this.price,
      required this.title,
      required this.catagory,
      required this.indexId,
      required this.collection});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
          color: ColorsResources.BLACK_COLOR,
          child: Padding(
            padding:
                const EdgeInsets.all(DimensionsResource.PADDING_SIZE_SMALL),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: CommonBackButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )),
                      Expanded(
                          flex: 4,
                          child: Align(
                              alignment: Alignment.center,
                              child:
                                  Text(StringResources.ADMIN_PRODUCT_DETAILS))),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateProductScreen(
                                                price: widget.price,
                                                catagory: widget.catagory,
                                                details: widget.details,
                                                title: widget.title,
                                                docId: widget.indexId,
                                                collectionName:
                                                    widget.collection),
                                      ));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorsResources.AMBER_ACCENT,
                                )),
                            IconButton(
                                onPressed: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    headerAnimationLoop: false,
                                    animType: AnimType.bottomSlide,
                                    dismissOnBackKeyPress: false,
                                    dismissOnTouchOutside: false,
                                    title: StringResources.DELETION_ALERT,
                                    desc: StringResources.DELETION_DISCRIPTION,
                                    descTextStyle:
                                        CustomTextStyles.contentTextStyle(
                                            ColorsResources.BLACK_COLOR),
                                    buttonsTextStyle: TextStyle(
                                        color: ColorsResources.WHITE_COLOR),
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () async {
                                      await FirebaseFirestore.instance
                                          .collection(widget.collection)
                                          .doc(widget.indexId)
                                          .delete()
                                          .then((value) =>
                                              Fluttertoast.showToast(
                                                  msg: StringResources
                                                      .DELETION_SUCCESSFUL))
                                          .then((value) =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BottomNavigationBarScreen(),
                                                  )));
                                    },
                                  ).show();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: ColorsResources.AMBER_ACCENT,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBoxPadding(),
                  Container(
                      clipBehavior: Clip.antiAlias,
                      height: mediaQuerySize.height *
                          ScreenPercentage.SCREEN_SIZE_30.h,
                      width: mediaQuerySize.width *
                          ScreenPercentage.SCREEN_SIZE_100.w,
                      decoration: BoxDecoration(
                          color: ColorsResources.WHITE_12,
                          borderRadius: BorderRadius.circular(
                              DimensionsResource.PADDING_SIZE_DEFAULT)),
                      child: CommonNetworkImage(imagePath: widget.imageUrl)),
                  const SizedBoxPadding(),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleTextStyle(
                        ColorsResources.WHITE_COLOR),
                  ),
                  Text(widget.catagory),
                  Text(
                    '${StringResources.PRICE} : ${widget.price}${StringResources.PKR}',
                    style: CustomTextStyles.textButtonStyle(
                        ColorsResources.AMBER_ACCENT),
                  ),
                  Center(
                      child: Text(StringResources.DETAILS,
                          style: CustomTextStyles.textButtonStyle(
                            ColorsResources.WHITE_COLOR,
                          ))),
                  Text(widget.details, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
