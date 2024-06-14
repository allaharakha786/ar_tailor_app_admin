import 'package:ar_admin/businessLogic/blocs/bottomNavigationBloc/bottom_navigation_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/bottomNavigationBloc/bottom_navigation_events.dart';
import 'package:ar_admin/businessLogic/blocs/bottomNavigationBloc/bottom_navigation_states.dart';
import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/constants/screen_percentage.dart';
import 'package:ar_admin/helper/constants/string_resources.dart';
import 'package:ar_admin/presentation/screens/all_product_screen.dart';
import 'package:ar_admin/presentation/screens/orders_screen.dart';
import 'package:ar_admin/presentation/screens/slider_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});
  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  late BottomNavigationBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<BottomNavigationBloc>(context);

    super.initState();
  }

  List pages = [
    const AllProductsScreen(),
    const SliderProductsScreen(),
    const OrdersScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationStates>(
      builder: (context, state) => Scaffold(
          body: SafeArea(
            child: pages[state.currentIndex],
          ),
          bottomNavigationBar: Container(
            color: ColorsResources.BLACK_COLOR,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                    tabActiveBorder:
                        Border.all(color: ColorsResources.WHITE_12),
                    backgroundColor: ColorsResources.BLACK_COLOR,
                    selectedIndex: state.currentIndex,
                    onTabChange: (value) {
                      bloc.add(CurrentIndexEvent(index: value));
                    },
                    gap: 8,
                    tabBorderRadius: 30,
                    padding: EdgeInsets.all(
                        (MediaQuery.of(context).size.height *
                            ScreenPercentage.SCREEN_SIZE_2)),
                    activeColor: ColorsResources.WHITE_COLOR,
                    color: ColorsResources.WHITE_70,
                    tabBackgroundColor: ColorsResources.WHITE_12,
                    tabs: [
                      GButton(
                        icon: Icons.shopping_cart,
                        text: StringResources.ALL_PRODUCTS,
                      ),
                      GButton(
                        icon: Icons.slideshow_rounded,
                        text: StringResources.SLIDER_PRODUCTS,
                      ),
                      GButton(
                        icon: Icons.archive,
                        text: StringResources.ORDERS,
                      ),
                    ]),
              ),
            ),
          )),
    );
  }
}
