part of 'app_bloc.dart';

sealed class AppEvent {}

final class AppStarted extends AppEvent {}

final class AppOnboardingCompleted extends AppEvent {}
