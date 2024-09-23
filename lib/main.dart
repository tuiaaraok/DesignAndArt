import 'dart:math';
import 'package:designer_and_artist/data/boxes.dart';
import 'package:designer_and_artist/data/model/order_archive_model.dart';
import 'package:designer_and_artist/data/model/place_an_order_model.dart';
import 'package:designer_and_artist/data/model/profile_model.dart';
import 'package:designer_and_artist/menu_page.dart';
import 'package:designer_and_artist/onboarding_page.dart';
import 'package:designer_and_artist/order_archive_page.dart';
import 'package:designer_and_artist/place_an_order_add_page.dart';
import 'package:designer_and_artist/profile_page.dart';
import 'package:designer_and_artist/profile_page_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(PlaceAnOrderModelAdapter());
  Hive.registerAdapter(OrderArchiveModelAdapter());
  await Hive.openBox<ProfileModel>(HiveBoxes.profile_model);
  await Hive.openBox<PlaceAnOrderModel>(HiveBoxes.place_an_order_model);
  await Hive.openBox<OrderArchiveModel>(HiveBoxes.order_archive_model);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // onGenerateRoute: NavigationApp.generateRoute,
            theme: ThemeData(
                scaffoldBackgroundColor: Color(0xFF98DFD5),
                appBarTheme: AppBarTheme(backgroundColor: Colors.transparent)),
            home: (Hive.box<ProfileModel>(HiveBoxes.profile_model).isNotEmpty ||
                    Hive.box<PlaceAnOrderModel>(HiveBoxes.place_an_order_model)
                        .isNotEmpty)
                ? MenuPage()
                : OnboardingPage(),
          );
        });
  }
}
