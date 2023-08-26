// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:tibicle_practical/bloc/exercise/models/exercise_model.dart';

class ExerciseState extends Equatable {
  ExerciseState({
    required this.model,
    required this.exerciseStateEnum,
    required this.message,
    required this.countDownTimeInDouble,
    required this.countDownTime,
    required this.completedRound,
  });

  final ExerciseModel model;
  final ExerciseStateEnum exerciseStateEnum;
  final String message;
  double countDownTimeInDouble;
  int countDownTime;
  final List<int> completedRound;

  @override
  List<Object?> get props => [model, exerciseStateEnum, message];

  ExerciseState copyWith({
    ExerciseModel? model,
    ExerciseStateEnum? exerciseStateEnum,
    String? message,
    double? countDownTimeInDouble,
    int? countDownTime,
    List<int>? completedRound,
  }) {
    return ExerciseState(
      model: model ?? this.model,
      exerciseStateEnum: exerciseStateEnum ?? this.exerciseStateEnum,
      message: message ?? this.message,
      countDownTimeInDouble: countDownTimeInDouble ?? this.countDownTimeInDouble,
      countDownTime: countDownTime ?? this.countDownTime,
      completedRound: completedRound ?? this.completedRound,
    );
  }
}

enum ExerciseStateEnum {
  initialize,
  loading,
  loadedSuccess,
  loadedFailed,
  startExercise,
  decreaseExerciseSecond,
  finishExercise,
}
