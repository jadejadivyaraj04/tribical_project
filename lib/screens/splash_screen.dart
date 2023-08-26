import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tibicle_practical/app/app_strings.dart';
import 'package:tibicle_practical/bloc/splash/splash_bloc.dart';
import 'package:tibicle_practical/bloc/splash/splash_event.dart';
import 'package:tibicle_practical/bloc/splash/splash_state.dart';
import 'package:tibicle_practical/screens/exercise_screen.dart';
import 'package:tibicle_practical/screens/widgets/common_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(LoadSplashData()),
      child: Scaffold(
        body: Center(
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExerciseScreen(),
                      ));
                });
              }
            },
            child: CommonManropeText(text: AppStrings.strSplashText, textSize: 24.sp),
          ),
        ),
      ),
    );
  }
}
