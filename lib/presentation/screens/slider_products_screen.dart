import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_states.dart';
import 'package:ar_admin/businessLogic/blocs/sliderProductBloc/slider_product_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/sliderProductBloc/slider_product_events.dart';
import 'package:ar_admin/businessLogic/blocs/sliderProductBloc/slider_product_states.dart';
import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/dimentions_resources.dart';
import 'package:ar_admin/helper/constants/screen_percentage.dart';
import 'package:ar_admin/helper/constants/string_resources.dart';
import 'package:ar_admin/helper/enums/status_enums.dart';
import 'package:ar_admin/helper/utills/text_styles.dart';
import 'package:ar_admin/presentation/screens/add_product_screen.dart';
import 'package:ar_admin/presentation/screens/product_details_screen.dart';
import 'package:ar_admin/presentation/widgets/common_network_image.dart';
import 'package:ar_admin/presentation/widgets/decorated_container.dart';
import 'package:ar_admin/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderProductsScreen extends StatefulWidget {
  const SliderProductsScreen({super.key});

  @override
  State<SliderProductsScreen> createState() => _SliderProductsScreenState();
}

class _SliderProductsScreenState extends State<SliderProductsScreen> {
  @override
  void initState() {
    BlocProvider.of<SliderProductBloc>(context).add(GetSliderProductEvent());
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
                        AddProductScreen(collectionName: 'sliderImages'),
                  ));
            },
            child: Icon(
              Icons.add,
              color: ColorsResources.BLACK_87,
            )),
        body: BlocListener<ProductBloc, ProductStates>(
          listener: (context, state) {},
          child: Container(
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
                    Center(child: Text(StringResources.SLIDER_PRODUCTS)),
                    BlocListener<SliderProductBloc, SliderProductStates>(
                      listener: (context, state) {},
                      child:
                          BlocBuilder<SliderProductBloc, SliderProductStates>(
                        builder: (context, state) {
                          if (state.states == StatusEnums.LOADING_STATE) {
                            return const CommonLoadingIndicator();
                          }
                          if (state.states ==
                              StatusEnums.PRODUCT_LOADED_STATE) {
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
                                                    collection: 'sliderImages',
                                                    indexId:
                                                        state.data[index].id,
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
                                                            color:
                                                                ColorsResources
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
      ),
    );
  }
}
