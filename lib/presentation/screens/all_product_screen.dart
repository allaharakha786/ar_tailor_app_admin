import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_events.dart';
import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_states.dart';
import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/dimentions_resources.dart';
import 'package:ar_admin/helper/constants/screen_percentage.dart';
import 'package:ar_admin/helper/constants/string_resources.dart';
import 'package:ar_admin/helper/enums/status_enums.dart';
import 'package:ar_admin/helper/utills/text_styles.dart';
import 'package:ar_admin/presentation/screens/add_product_screen.dart';
import 'package:ar_admin/presentation/screens/product_details_screen.dart';
import 'package:ar_admin/helper/utills/alert_dialog.dart';
import 'package:ar_admin/presentation/widgets/common_network_image.dart';
import 'package:ar_admin/presentation/widgets/decorated_container.dart';
import 'package:ar_admin/presentation/widgets/loading_indicator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(GetProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorsResources.AMBER_ACCENT,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddProductScreen(collectionName: 'cloths'),
                  ));
            },
            child: Icon(
              Icons.add,
              color: ColorsResources.BLACK_87,
            )),
        body: Container(
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100,
          color: ColorsResources.BLACK_COLOR,
          child: Padding(
            padding:
                const EdgeInsets.all(DimensionsResource.PADDING_SIZE_SMALL),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      StringResources.ADMINISTRATIVE_PANEL,
                      style: CustomTextStyles.titleTextStyle(
                          ColorsResources.WHITE_70),
                    ),
                  ),
                  Center(child: Text(StringResources.ALL_PRODUCTS)),
                  BlocListener<ProductBloc, ProductStates>(
                    listener: (context, state) {
                      if (state.states == StatusEnums.ERROR_STATE) {
                        AwesomeDialogAlert.showDialogAlert(
                            context,
                            DialogType.error,
                            StringResources.ERROR_ALERT,
                            StringResources.ERROR_MESSAGE,
                            () {});
                      }
                    },
                    child: BlocBuilder<ProductBloc, ProductStates>(
                      builder: (context, state) {
                        if (state.states == StatusEnums.LOADING_STATE) {
                          return const CommonLoadingIndicator();
                        }
                        if (state.states == StatusEnums.PRODUCT_LOADED_STATE) {
                          return state.data.isEmpty
                              ? Center(
                                  child: Text(
                                  StringResources.NO_PRODUCT_FOUND,
                                  style: CustomTextStyles.contentTextStyle(
                                      ColorsResources.WHITE_COLOR),
                                ))
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: DimensionsResource
                                          .PADDING_SIZE_SMALL),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(state.data.length,
                                        (index) {
                                      dynamic data = state.data[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsScreen(
                                                  collection: 'cloths',
                                                  indexId: state.data[index].id,
                                                  catagory: state.data[index]
                                                      ['catagory'],
                                                  imageUrl: state.data[index]
                                                      ['imageUrl'],
                                                  details: state.data[index]
                                                      ['details'],
                                                  price: state.data[index]
                                                      ['price'],
                                                  title: state.data[index]
                                                      ['title'],
                                                ),
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              DimensionsResource
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          child: DecoratedContainer(
                                              height: ScreenPercentage
                                                  .SCREEN_SIZE_25,
                                              width: ScreenPercentage
                                                  .SCREEN_SIZE_44,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    DimensionsResource
                                                        .PADDING_SIZE_EXTRA_SMALL),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: DecoratedContainer(
                                                          color: ColorsResources
                                                              .WHITE_24,
                                                          height: ScreenPercentage
                                                              .SCREEN_SIZE_15,
                                                          width: ScreenPercentage
                                                              .SCREEN_SIZE_38,
                                                          child: CommonNetworkImage(
                                                              imagePath: state
                                                                          .data[
                                                                      index][
                                                                  'imageUrl'])),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        ' ${data['title'].toString().length < 16 ? data['title'] : '${data['title'].toString().substring(0, 15)}...'} ',
                                                        style: CustomTextStyles
                                                            .contentTextStyle(
                                                                ColorsResources
                                                                    .WHITE_COLOR),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            data['catagory'],
                                                          )),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            '${data['price']} ${StringResources.PKR}',
                                                            style: CustomTextStyles
                                                                .contentTextStyle(
                                                                    ColorsResources
                                                                        .AMBER_ACCENT),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      );
                                    }),
                                  ));
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
