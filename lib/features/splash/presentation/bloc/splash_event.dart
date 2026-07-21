part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {}

class InitializeApp extends SplashEvent {}
