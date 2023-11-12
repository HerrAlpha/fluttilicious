import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttilicious/colors.dart';
import 'package:fluttilicious/fluttilicious.dart';
import 'package:get/get.dart';
// import 'package:heart_fly/route/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: Size(360, 640),
      builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fluttilicious',
          // getPages: Pages.listPages(),
          // color: Colours.darkmode,
          home: ExamplePage()),
    );
  }
}

class ExamplePage extends StatelessWidget {
  ExamplePage({super.key});

  List<Widget> pages = [
    Container(
      color: FluttilColors.businessAqua,
      child: Text('Business Aqua (165, 216, 221)'),
    ),
    Container(
      color: FluttilColors.businessBlue,
      child: Text('Business Blue (0, 145, 213)'),
    ),
    Container(
      color: FluttilColors.comCosmeticPink,
      child: Text('Cosmetic Pink (222, 164, 160)'),
    ),
    Container(
      color: FluttilColors.comFurnitureLightBlue,
      child: Text('Furniture Light Blue (156, 176, 224)'),
    ),
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  List<String> titles = [
    'Home',
    'Favorite',
    'Cart',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomMenuBar.uniColor(pages: pages, icons: icons, titles: titles),
    );
  }
}
