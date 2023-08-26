abstract class ExerciseEvent {}

class LoadExerciseData extends ExerciseEvent {}

class DecreaseExerciseSecond extends ExerciseEvent {
  final double countDownTimeInDouble;
  final int countDownTime;

  DecreaseExerciseSecond({required this.countDownTimeInDouble, required this.countDownTime});

  List<Object?> get props => [countDownTimeInDouble, countDownTime];
}

class FinishExercise extends ExerciseEvent {}
