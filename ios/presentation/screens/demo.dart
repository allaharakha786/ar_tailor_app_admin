import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_events.dart';
import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_states.dart';
import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/enums/status_enums.dart';
import 'package:ar_admin/helper/utills/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/loading_indicator.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(GetProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 400,
          width: 400,
          color: Colors.amber,
          child: BlocListener<ProductBloc, ProductStates>(
            listener: (context, state) {
              if (state.states == StatusEnums.ERROR_STATE) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('nothing')));
              }
            },
            child: BlocBuilder<ProductBloc, ProductStates>(
              builder: (context, state) {
                if (state.states == StatusEnums.LOADING_STATE) {
                  return const CommonLoadingIndicator();
                }
                if (state.states == StatusEnums.PRODUCT_LOADED_STATE) {
                  return Column(
                    children: [
                      Text(
                        'Administrative Panel',
                        style: CustomTextStyles.titleTextStyle(
                            ColorsResources.WHITE_70),
                      ),
                      const Text('All Products'),
                      Text(state.data.length.toString())
                      // ListView.builder(
                      //   itemCount: state.data.length,
                      //   itemBuilder: (context, index) {
                      //     return ListTile(
                      //       tileColor: Colors.white,
                      //     );
                      //   },
                      // )
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
