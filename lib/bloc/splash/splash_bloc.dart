import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tibicle_practical/bloc/splash/splash_event.dart';
import 'package:tibicle_practical/bloc/splash/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<LoadSplashData>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      emit(SplashLoaded());
    });
  }
}
