import 'package:ar_admin/businessLogic/blocs/bottomNavigationBloc/bottom_navigation_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/ordersBloc/order_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/sliderProductBloc/slider_product_bloc.dart';
import 'package:ar_admin/businessLogic/blocs/updateOrderBloc/update_order_bloc.dart';
import 'package:ar_admin/helper/constants/colors_resources.dart';
import 'package:ar_admin/helper/utills/text_styles.dart';
import 'package:ar_admin/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyB7qo36HOmtuqEGEaGLsg2OX-sNhrrw5_U',
          appId: '1:11809106901:android:a8262ce951b2e3a2796b5c',
          messagingSenderId: '11809106901',
          projectId: 'oerassssssssssssssss',
          storageBucket: 'oerassssssssssssssss.appspot.com'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: Size(mediaQuerySize.width, mediaQuerySize.height),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OrderBloc(),
          ),
          BlocProvider(
            create: (context) => ProductBloc(),
          ),
          BlocProvider(
            create: (context) => UpdateOrderBloc(),
          ),
          BlocProvider(
            create: (context) => BottomNavigationBloc(),
          ),
          BlocProvider(
            create: (context) => SliderProductBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              textTheme: TextTheme(
                  bodyMedium: CustomTextStyles.contentTextStyle(
                      ColorsResources.WHITE_70),
                  bodySmall: TextStyle(color: ColorsResources.WHITE_70),
                  bodyLarge: TextStyle(color: ColorsResources.WHITE_70))),
          home: const SpalshScreen(),
        ),
      ),
    );
  }
}
