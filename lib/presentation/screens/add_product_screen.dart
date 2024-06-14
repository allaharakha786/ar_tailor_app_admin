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
import 'package:ar_admin/presentation/widgets/common_network_image.dart';

import 'package:ar_admin/presentation/widgets/common_textfield.dart';
import 'package:ar_admin/presentation/widgets/loading_indicator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatefulWidget {
  String collectionName;
  AddProductScreen({super.key, required this.collectionName});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late List<TextEditingController> controllers = [];

  @override
  void initState() {
    for (int i = 0; i < 4; i++) {
      controllers.add(TextEditingController());
    }

    BlocProvider.of<ProductBloc>(context).add(InitialstateEvent());
    BlocProvider.of<ProductBloc>(context).add(ClearImagePathEvent());

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
                if (state.states == StatusEnums.IMAGE_UPLOADING_STATE) {
                  Fluttertoast.showToast(
                    msg: StringResources.UPLOADING_IMAGE,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
                if (state.states == StatusEnums.INITIAL_STATE) {}
                if (state.states == StatusEnums.ERROR_STATE) {
                  AwesomeDialogAlert.showDialogAlert(
                      context,
                      DialogType.error,
                      StringResources.ERROR_ALERT,
                      StringResources.ERROR_MESSAGE,
                      () {});
                }
                if (state.states == StatusEnums.PRODUCT_ADDED_STATE) {
                  AwesomeDialogAlert.showDialogAlert(
                      context,
                      DialogType.success,
                      StringResources.SUCCESS_ALERT,
                      widget.collectionName.contains('cloths')
                          ? StringResources.PRODUCT_ADDED
                          : StringResources.SLIDER_PRODUCT_ADDED, () {
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
                                  BlocProvider.of<ProductBloc>(context)
                                      .add(GetProductEvent());
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
                                    widget.collectionName.contains('cloths')
                                        ? StringResources.ADD_NEW_PRODUCT
                                        : StringResources
                                            .ADD_NEW_SLIDER_PRODUCT,
                                    style: CustomTextStyles.titleTextStyle(
                                        ColorsResources.WHITE_70),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(widget.collectionName.contains('cloths')
                            ? StringResources.DETAILS_TO_ADD_PRODUCT
                            : StringResources.DETAILS_TO_ADD_SLIDER_PRODUCT),
                        SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                4,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(
                                          DimensionsResource
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      child: CommonTextField(
                                        prefixIcon: Icon(
                                            ListData.textFieldIcons[index]),
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
                        ),
                        state.isImageUploading
                            ? const CommonLoadingIndicator()
                            : state.imageUrl.isEmpty
                                ? CommonButton(
                                    text: StringResources.UPLOAD_IMAGE,
                                    onTap: () {
                                      BlocProvider.of<ProductBloc>(context)
                                          .add(UploadProductImageEvent());
                                    },
                                    width: mediaQuerySize.width *
                                        ScreenPercentage.SCREEN_SIZE_50.w,
                                    isloading: false)
                                : Container(
                                    clipBehavior: Clip.antiAlias,
                                    height: mediaQuerySize.height *
                                        ScreenPercentage.SCREEN_SIZE_20.h,
                                    width: mediaQuerySize.width *
                                        ScreenPercentage.SCREEN_SIZE_90.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            DimensionsResource.RADIUS_DEFAULT),
                                        color: ColorsResources.WHITE_12),
                                    child: CommonNetworkImage(
                                        imagePath: state.imageUrl)),
                        Padding(
                          padding: const EdgeInsets.all(
                              DimensionsResource.PADDING_SIZE_DEFAULT),
                          child: CommonButton(
                              text: widget.collectionName.contains('cloths')
                                  ? StringResources.ADD_PRODUCT
                                  : StringResources.ADD_SLIDER_PRODUCT,
                              onTap: () {
                                if (key.currentState!.validate()) {
                                  List<String> productData = [
                                    controllers[0].text,
                                    controllers[1].text,
                                    controllers[2].text,
                                    controllers[3].text,
                                    state.imageUrl
                                  ];

                                  if (state.imageUrl.isNotEmpty) {
                                    BlocProvider.of<ProductBloc>(context).add(
                                        AddProductEvent(
                                            data: productData,
                                            collectionName:
                                                widget.collectionName));
                                  } else {
                                    AwesomeDialogAlert.showDialogAlert(
                                        context,
                                        DialogType.warning,
                                        StringResources.UPLOAD_IMAGE,
                                        'Please upload picture of your product ',
                                        () {});
                                  }
                                }
                              },
                              width: widget.collectionName.contains('cloths')
                                  ? mediaQuerySize.width *
                                      ScreenPercentage.SCREEN_SIZE_45.w
                                  : mediaQuerySize.width *
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
