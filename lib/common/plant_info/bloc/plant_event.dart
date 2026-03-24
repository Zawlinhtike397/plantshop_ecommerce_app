part of 'plant_bloc.dart';

sealed class PlantEvent extends Equatable {
  const PlantEvent();

  @override
  List<Object?> get props => [];
}

final class UploadPlantDataEvent extends PlantEvent {}

final class LoadPlantsEvent extends PlantEvent {
  final String category;
  final String? searchQuery;

  const LoadPlantsEvent({this.category = 'All', this.searchQuery});

  @override
  List<Object?> get props => [category, searchQuery];
}

final class LoadMorePlantsEvent extends PlantEvent {}

final class LoadCategoriesEvent extends PlantEvent {}
