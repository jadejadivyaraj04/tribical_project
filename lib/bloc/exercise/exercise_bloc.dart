import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tibicle_practical/bloc/exercise/exercise_event.dart';
import 'package:tibicle_practical/bloc/exercise/exercise_state.dart';
import 'package:tibicle_practical/bloc/exercise/models/exercise_model.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc()
      : super(ExerciseState(
          model: ExerciseModel(),
          exerciseStateEnum: ExerciseStateEnum.initialize,
          message: '',
          completedRound: const [],
          countDownTimeInDouble: 100,
          countDownTime: 10,
        )) {
    on<LoadExerciseData>((event, emit) async {
      emit(state.copyWith(exerciseStateEnum: ExerciseStateEnum.loading));
      await Future.delayed(const Duration(seconds: 3));
      // TODO: make api call here
      emit(
        state.copyWith(
          exerciseStateEnum: ExerciseStateEnum.loadedSuccess,
          message: 'Exercise Loaded successfully',
          countDownTimeInDouble: 100,
          countDownTime: 10,
          model: ExerciseModel(
            numberOfSet: 12,
            exerciseName: 'Sit ups',
            exerciseTimeInSecond: 10,
            exerciseCalories: 100,
            exerciseDesc:
                'Follow the rhythm and start burning the fat like never before! Please take a small break after you are done with the exercise!',
            exerciseUrl: 'https://i.ibb.co/7YWqMWh/Rectangle-5842.png',
          ),
        ),
      );
    });

    on<DecreaseExerciseSecond>((event, emit) async {
      emit(state.copyWith(exerciseStateEnum: ExerciseStateEnum.startExercise));
      emit(state.copyWith(
          exerciseStateEnum: ExerciseStateEnum.decreaseExerciseSecond,
          countDownTimeInDouble: event.countDownTimeInDouble,
          countDownTime: event.countDownTime));
    });

    on<FinishExercise>((event, emit) async {
      emit(state.copyWith(exerciseStateEnum: ExerciseStateEnum.finishExercise));
    });
  }
}
