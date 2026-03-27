import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/data/repositories/plant_repository.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  final PlantRepository plantRepository;

  int _start = 0;
  final int _limit = 4;

  PlantBloc({required this.plantRepository}) : super(PlantInitial()) {
    on<UploadPlantDataEvent>(_uploadPlants);
    on<LoadPlantsEvent>(_loadPlants);
    on<LoadMorePlantsEvent>(_loadMorePlants);
  }

  Future<void> _uploadPlants(
    UploadPlantDataEvent event,
    Emitter<PlantState> emit,
  ) async {
    try {
      emit(PlantUploading());

      await plantRepository.uploadPlants();

      emit(PlantUploaded());
    } catch (e) {
      emit(PlantError(e.toString()));
    }
  }

  Future<void> _loadPlants(
    LoadPlantsEvent event,
    Emitter<PlantState> emit,
  ) async {
    try {
      emit(PlantLoading());

      _start = 0;
      final plants = await plantRepository.fetchPlants(
        start: _start,
        limit: _limit,
        category: event.category,
        searchQuery: event.searchQuery,
      );

      final categories = await plantRepository.fetchCategories();
      emit(
        PlantLoaded(
          plants: plants,
          categories: categories,
          hasReachedMax: plants.length < _limit,
          selectedCategory: event.category,
          searchQuery: event.searchQuery ?? '',
        ),
      );
    } catch (e) {
      emit(PlantError(e.toString()));
    }
  }

  Future<void> _loadMorePlants(
    LoadMorePlantsEvent event,
    Emitter<PlantState> emit,
  ) async {
    if (state is! PlantLoaded) return;

    final currentState = state as PlantLoaded;

    if (currentState.hasReachedMax || currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final start = currentState.plants.length;

      final newPlants = await plantRepository.fetchPlants(
        start: start,
        limit: _limit,
        category: currentState.selectedCategory,
        searchQuery: currentState.searchQuery ?? '',
      );

      emit(
        currentState.copyWith(
          plants: [...currentState.plants, ...newPlants],
          hasReachedMax: newPlants.length < _limit,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(PlantError(e.toString()));
    }
  }
}
