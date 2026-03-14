part of 'plant_bloc.dart';

sealed class PlantState extends Equatable {
  const PlantState();

  @override
  List<Object> get props => [];
}

final class PlantInitial extends PlantState {}

final class PlantUploading extends PlantState {}

final class PlantUploaded extends PlantState {}

final class PlantLoading extends PlantState {}

final class PlantLoaded extends PlantState {
  final List<PlantModel> plants;

  const PlantLoaded(this.plants);

  @override
  List<Object> get props => [plants];
}

final class PlantError extends PlantState {
  final String message;

  const PlantError(this.message);
}
