import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tibicle_practical/screens/widgets/my_scroll_behaviour.dart';

import 'app/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppTheme.designSize,
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyScrollBehavior(),
            child: child!,
          );
        },
        home: const SplashScreen(),
      ),
    );
  }
}
