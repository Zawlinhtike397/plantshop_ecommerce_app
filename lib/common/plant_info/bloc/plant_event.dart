part of 'plant_bloc.dart';

sealed class PlantEvent extends Equatable {
  const PlantEvent();

  @override
  List<Object> get props => [];
}

final class UploadPlantDataEvent extends PlantEvent {}

final class LoadPlantsEvent extends PlantEvent {}
