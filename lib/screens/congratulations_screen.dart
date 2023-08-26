import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tibicle_practical/app/app_images.dart';
import 'package:tibicle_practical/app/app_strings.dart';
import 'package:tibicle_practical/screens/exercise_screen.dart';
import 'package:tibicle_practical/screens/widgets/common_text.dart';

import '../app/app_colors.dart';

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 19.h,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Image.asset(
                      AppImages.icCongratulations,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 320.h,
                      ),
                      CommonMeaCulpaText(
                        text: AppStrings.strCongratulations,
                        textSize: 40.sp,
                        color: AppColors.color3B4860,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CommonManropeText(
                        text: AppStrings.strCongratulationsMsg1,
                        textSize: 14.sp,
                        textAlign: TextAlign.center,
                        color: AppColors.colorA9A9A9,
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const ExerciseScreen()), (Route<dynamic> route) => false);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.colorED7844,
                  ),
                  child: CommonManropeText(
                    text: AppStrings.strStartAgain,
                    textSize: 16.sp,
                    color: AppColors.colorWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
