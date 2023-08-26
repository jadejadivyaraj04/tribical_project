import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tibicle_practical/app/app_colors.dart';
import 'package:tibicle_practical/app/app_images.dart';
import 'package:tibicle_practical/app/app_strings.dart';
import 'package:tibicle_practical/bloc/exercise/exercise_bloc.dart';
import 'package:tibicle_practical/bloc/exercise/exercise_event.dart';
import 'package:tibicle_practical/bloc/exercise/exercise_state.dart';
import 'package:tibicle_practical/screens/congratulations_screen.dart';
import 'package:tibicle_practical/screens/widgets/common_text.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  var setsOfExerciseWidgets = <Widget>[];
  double countDownTimeInDouble = 0;
  int countDownTime = 0;

  /// to start exercise
  void startExercise(BuildContext context) {
    const interval = Duration(seconds: 1);
    Timer.periodic(interval, (Timer timer) {

      if (countDownTimeInDouble != 0) {
        context
            .read<ExerciseBloc>()
            .add(DecreaseExerciseSecond(countDownTimeInDouble: countDownTimeInDouble, countDownTime: countDownTime));
      } else {
        context.read<ExerciseBloc>().add(FinishExercise());
        timer.cancel();
      }
    });
  }

  /// to create widgets for sets of exercise dynamically
  void createDynamicWidget(int numberOfSet, List<int> completedRound) {
    setsOfExerciseWidgets.clear();
    for (int i = 1; i <= numberOfSet; i++) {
      setsOfExerciseWidgets.add(
        completedRound.contains(i)
            ? Container(
                height: 30.w,
                width: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  color: AppColors.colorED7844.withOpacity(0.5),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      CommonManropeText(
                        text: i.toString(),
                        textSize: 14.sp,
                        color: AppColors.colorWhite,
                      ),
                      Icon(Icons.check, size: 16.w),
                    ],
                  ),
                ),
              )
            : Container(
                height: 30.w,
                width: 30.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: AppColors.colorED7844,
                    border: completedRound.isNotEmpty && completedRound.last + 1 == i
                        ? Border.all(color: AppColors.colorBlack, width: 1.4.w)
                        : Border.all(color: Colors.transparent)),
                child: Center(
                  child: CommonManropeText(
                    text: i.toString(),
                    textSize: 14.sp,
                    color: AppColors.colorWhite,
                  ),
                ),
              ),
      );
    }
  }

  // convert into formatted time
  String formatTime(int seconds) {
    int sec = seconds % 60;
    int min = (seconds / 60).floor();
    String minute = "$min";
    String second = "$sec";
    return min == 0 ? '$second sec' : '$minute min $second sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocProvider(
            create: (context) => ExerciseBloc()..add(LoadExerciseData()),
            child: BlocConsumer<ExerciseBloc, ExerciseState>(
              listener: (context, state) {
                debugPrint('state: ${state.exerciseStateEnum.name}');
                if (state.exerciseStateEnum == ExerciseStateEnum.loadedSuccess) {
                  countDownTimeInDouble = (state.model.exerciseTimeInSecond ?? 0) * 10;
                  countDownTime = state.model.exerciseTimeInSecond ?? 0;
                  createDynamicWidget(state.model.numberOfSet ?? 0, state.completedRound);
                } else if (state.exerciseStateEnum == ExerciseStateEnum.finishExercise) {
                  countDownTimeInDouble = (state.model.exerciseTimeInSecond ?? 0) * 10;
                  countDownTime = state.model.exerciseTimeInSecond ?? 0;
                  if (state.completedRound.isEmpty) {
                    state.completedRound = [1];
                  } else {
                    state.completedRound.add(state.completedRound.last + 1);
                  }
                  createDynamicWidget(state.model.numberOfSet ?? 0, state.completedRound);
                  if (state.model.numberOfSet == state.completedRound.last) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CongratulationsScreen(),
                    ));
                  }
                } else if (state.exerciseStateEnum == ExerciseStateEnum.decreaseExerciseSecond) {
                  countDownTimeInDouble = state.countDownTimeInDouble - 10;
                  countDownTime = state.countDownTime - 1;
                }
              },
              builder: (context, state) {
                return state.exerciseStateEnum == ExerciseStateEnum.loading
                    ? Center(child: CircularProgressIndicator(color: AppColors.primaryPalette))
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 11.h),
                            Center(
                              child: CommonManropeText(
                                text: AppStrings.strExercise,
                                textSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 23.h),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 16.h, bottom: 20.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: AppColors.colorF6F6F6,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonManropeText(
                                    text: AppStrings.strRepetitionExercise,
                                    textSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  SizedBox(height: 21.h),
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    alignment: WrapAlignment.start,
                                    spacing: 17.w,
                                    runSpacing: 17.w,
                                    children: setsOfExerciseWidgets,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              child: state.model.exerciseUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: state.model.exerciseUrl!,
                                      height: 160.w,
                                      width: MediaQuery.of(context).size.width,
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    )
                                  : const Offstage(),
                            ),
                            CommonManropeText(
                              text: state.model.exerciseName ?? '',
                              textSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.color3B4860,
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Container(
                                  height: 30.w,
                                  width: 30.w,
                                  margin: EdgeInsets.only(right: 10.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppColors.colorED7844.withOpacity(0.1),
                                  ),
                                  child: Image.asset(
                                    AppImages.icRoundAlarm,
                                    height: 16.w,
                                    width: 16.w,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonManropeText(
                                      text: AppStrings.strTotalTime,
                                      textSize: 10.sp,
                                      color: AppColors.colorA9A9A9,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    CommonManropeText(
                                      text: formatTime(
                                          (state.model.numberOfSet ?? 0) * (state.model.exerciseTimeInSecond ?? 0)),
                                      textSize: 12.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 30.w),
                                Container(
                                  height: 30.w,
                                  width: 30.w,
                                  margin: EdgeInsets.only(right: 10.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppColors.color3B4860.withOpacity(0.1),
                                  ),
                                  child: Image.asset(
                                    AppImages.icCalories,
                                    height: 14.w,
                                    width: 14.w,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonManropeText(
                                      text: AppStrings.strTotalCalories,
                                      textSize: 10.sp,
                                      color: AppColors.colorA9A9A9,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    CommonManropeText(
                                      text: '${state.model.exerciseCalories}',
                                      textSize: 12.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            CommonManropeText(
                              text: state.model.exerciseDesc ?? '',
                              textSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorA9A9A9,
                            ),
                            SizedBox(height: 34.h),
                            Center(
                              child: SizedBox(
                                height: 150.w,
                                width: 150.w,
                                child: Stack(
                                  children: [
                                    DashedCircularProgressBar.aspectRatio(
                                      aspectRatio: 1,
                                      progress: countDownTimeInDouble,
                                      sweepAngle: 360,
                                      foregroundColor: AppColors.colorED7844,
                                      backgroundColor: AppColors.colorA9A9A9,
                                      foregroundStrokeWidth: 8,
                                      backgroundStrokeWidth: 6,
                                      backgroundGapSize: 10,
                                      backgroundDashSize: 0.5,
                                      seekColor: AppColors.colorED7844,
                                      seekSize: 22,
                                      animation: true,
                                      maxProgress: (state.model.exerciseTimeInSecond ?? 0) * 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(18.w),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: CircleBorder(
                                          side: BorderSide(width: 24.w, color: AppColors.colorA9A9A9.withOpacity(0.5)),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: countDownTime == state.model.exerciseTimeInSecond
                                          ? InkWell(
                                              onTap: () {
                                                if (state.completedRound.isEmpty ||
                                                    state.model.numberOfSet != state.completedRound.last) {
                                                  countDownTimeInDouble = (state.model.exerciseTimeInSecond ?? 0) * 10;
                                                  countDownTime = state.model.exerciseTimeInSecond ?? 0;
                                                  startExercise(context);
                                                }
                                              },
                                              child: Icon(
                                                Icons.play_arrow,
                                                size: 34.h,
                                                color: AppColors.colorED7844,
                                              ),
                                            )
                                          : CommonManropeText(
                                              text: '$countDownTime',
                                              textSize: 40.sp,
                                              color: AppColors.color3B4860,
                                              fontWeight: FontWeight.w700,
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 54.h),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
