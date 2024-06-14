import 'package:ar_admin/businessLogic/blocs/updateOrderBloc/update_order_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/updateOrderBloc/update_order_events.dart';
import 'package:ar_admin/businessLogic/blocs/updateOrderBloc/update_order_states.dart';
import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/dimentions_resources.dart';
import 'package:ar_admin/helper/constants/screen_percentage.dart';
import 'package:ar_admin/helper/constants/string_resources.dart';
import 'package:ar_admin/helper/enums/status_enums.dart';
import 'package:ar_admin/helper/utills/alert_dialog.dart';
import 'package:ar_admin/presentation/screens/bottom_navigation_bar_screen.dart';
import 'package:ar_admin/presentation/widgets/common_backbutton.dart';
import 'package:ar_admin/presentation/widgets/common_button.dart';
import 'package:ar_admin/presentation/widgets/drop_down_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ModifyOrderScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  dynamic data;
  dynamic docId;
  ModifyOrderScreen({super.key, required this.data, required this.docId});
  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocListener<UpdateOrderBloc, UpdateOrderStates>(
          listener: (context, state) {
            if (state.states == StatusEnums.ORDER_STATUS_UPDATED) {
              AwesomeDialogAlert.showDialogAlert(
                  context,
                  DialogType.success,
                  StringResources.SUCCESS_ALERT,
                  StringResources.ORDER_UPDATED, () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationBarScreen(),
                    ));
              });
            }
            if (state.states == StatusEnums.ERROR_STATE) {
              AwesomeDialogAlert.showDialogAlert(
                  context,
                  DialogType.error,
                  StringResources.ERROR_ALERT,
                  StringResources.ERROR_MESSAGE, () {
                Navigator.pop(context);
              });
            }
          },
          child: BlocBuilder<UpdateOrderBloc, UpdateOrderStates>(
            builder: (context, state) => Container(
              height:
                  mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
              width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
              color: ColorsResources.BLACK_COLOR,
              child: Padding(
                padding: const EdgeInsets.all(
                    DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                            child: CommonBackButton(
                                onTap: () => Navigator.pop(context))),
                        Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: DimensionsResource.PADDING_SIZE_LARGE),
                              child: Center(
                                  child: Text(StringResources.UPDATE_STATUS)),
                            ))
                      ],
                    ),
                    Text(StringResources.PAYMENT_STATUS),
                    CommonDropDownBotton(
                      value: state.paymentValue,
                      onChange: (value) {
                        BlocProvider.of<UpdateOrderBloc>(context).add(
                            PaymentDropDownValueEvent(paymentValue: value));
                      },
                    ),
                    Text(StringResources.ORDER_STATUS),
                    CommonDropDownBotton(
                      value: state.orderValue,
                      onChange: (value) {
                        BlocProvider.of<UpdateOrderBloc>(context)
                            .add(OrderDropDownValueEvent(orderValue: value));
                      },
                    ),
                    CommonButton(
                        text: StringResources.UPDATE_STATUS,
                        onTap: () {
                          BlocProvider.of<UpdateOrderBloc>(context).add(
                              UpdateOrderStatusEvent(
                                  orderValue: state.orderValue,
                                  paymentValue: state.paymentValue,
                                  indexId: docId));
                        },
                        width: mediaQuerySize.width *
                            ScreenPercentage.SCREEN_SIZE_55.w,
                        isloading: state.isLoading)
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
