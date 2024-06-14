import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_events.dart';
import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_states.dart';

import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/dimentions_resources.dart';
import 'package:ar_admin/helper/constants/screen_percentage.dart';
import 'package:ar_admin/helper/constants/string_resources.dart';
import 'package:ar_admin/helper/data/list_data.dart';
import 'package:ar_admin/helper/enums/status_enums.dart';
import 'package:ar_admin/helper/extenstions/validation_extension.dart';
import 'package:ar_admin/helper/utills/text_styles.dart';
import 'package:ar_admin/presentation/screens/bottom_navigation_bar_screen.dart';
import 'package:ar_admin/helper/utills/alert_dialog.dart';
import 'package:ar_admin/presentation/widgets/common_button.dart';
import 'package:ar_admin/presentation/widgets/common_backbutton.dart';

import 'package:ar_admin/presentation/widgets/common_textfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class UpdateProductScreen extends StatefulWidget {
  String title;
  String price;
  String details;
  String catagory;
  dynamic docId;
  String collectionName;

  UpdateProductScreen(
      {super.key,
      required this.price,
      required this.catagory,
      required this.details,
      required this.title,
      required this.docId,
      required this.collectionName});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late List<TextEditingController> controllers = [];

  @override
  void initState() {
    for (int i = 0; i < 4; i++) {
      controllers.add(TextEditingController());
      controllers[i].text = [
        widget.title,
        widget.details,
        widget.price,
        widget.catagory,
      ][i];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: key,
          child: Container(
            height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
            width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
            color: ColorsResources.BLACK_COLOR,
            child: BlocListener<ProductBloc, ProductStates>(
              listener: (context, state) {
                if (state.states == StatusEnums.ERROR_STATE) {
                  AwesomeDialogAlert.showDialogAlert(
                      context,
                      DialogType.error,
                      StringResources.ERROR_ALERT,
                      StringResources.ERROR_MESSAGE, () {
                    Navigator.pop(context);
                  });
                }
                if (state.states == StatusEnums.PRODUCT_UPDATED_STATE) {
                  AwesomeDialogAlert.showDialogAlert(
                      context,
                      DialogType.success,
                      StringResources.SUCCESS_ALERT,
                      StringResources.CHANGES_SAVED, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const BottomNavigationBarScreen(),
                        ));
                  });
                }
              },
              child: BlocBuilder<ProductBloc, ProductStates>(
                builder: (context, state) => Padding(
                  padding: const EdgeInsets.all(
                      DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CommonBackButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: DimensionsResource
                                          .PADDING_SIZE_EXTRA_LARGE),
                                  child: Text(
                                    StringResources.UPDATE_YOUR_PRODUCT,
                                    style: CustomTextStyles.titleTextStyle(
                                        ColorsResources.WHITE_70),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(StringResources.MAKE_CHANGES_TO_UPDATE),
                        Column(
                          children: List.generate(
                              4,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(
                                        DimensionsResource
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    child: CommonTextField(
                                      prefixIcon:
                                          Icon(ListData.textFieldIcons[index]),
                                      hintText: ListData.textFieldText[index],
                                      controller: controllers[index],
                                      validator: (value) {
                                        if (value!.fieldValidation()) {
                                          return StringResources
                                              .EMPTY_FIELD_VALIDATION_MESSAGE;
                                        }
                                        return null;
                                      },
                                      isBorder: true,
                                    ),
                                  )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                              DimensionsResource.PADDING_SIZE_DEFAULT),
                          child: CommonButton(
                              text: StringResources.UPDATE_PRODUCT,
                              onTap: () {
                                if (key.currentState!.validate()) {
                                  BlocProvider.of<ProductBloc>(context).add(
                                      UpdateProductEvent(
                                          title: controllers[0].text,
                                          details: controllers[1].text,
                                          price: controllers[2].text,
                                          catagory: controllers[3].text,
                                          docId: widget.docId,
                                          collectionName:
                                              widget.collectionName));
                                }
                              },
                              width: mediaQuerySize.width *
                                  ScreenPercentage.SCREEN_SIZE_65.w,
                              isloading: state.isLoading),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
