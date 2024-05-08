import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allScreens/home_screen.dart';
import 'package:vpn_basic_project/appPreferences/appPreferences.dart';

late Size sizeScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Free Vpn',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              centerTitle: true, elevation: 3
          ),
      ),
      themeMode: AppPreferences.isMOdeDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
              centerTitle: true, elevation: 3
          ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}


extension AppTheme on ThemeData
{
  Color get lightTextColor => AppPreferences.isMOdeDark ? Colors.white70 : Colors.black54;
  Color get bottomNavigationColor => AppPreferences.isMOdeDark ? Colors.white12 : Colors.redAccent;
}
