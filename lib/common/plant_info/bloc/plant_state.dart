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
  final List<String> categories;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String selectedCategory;
  final String searchQuery;

  const PlantLoaded({
    required this.plants,
    required this.categories,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.selectedCategory = 'All',
    this.searchQuery = '',
  });

  PlantLoaded copyWith({
    List<PlantModel>? plants,
    List<String>? categories,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return PlantLoaded(
      plants: plants ?? this.plants,
      categories: categories ?? this.categories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [
    plants,
    categories,
    hasReachedMax,
    isLoadingMore,
    selectedCategory,
    searchQuery,
  ];
}

final class PlantError extends PlantState {
  final String message;

  const PlantError(this.message);
}
