import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/common/plant_info/repository/plant_repository.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  final PlantRepository plantRepository;

  PlantBloc({required this.plantRepository}) : super(PlantInitial()) {
    on<UploadPlantDataEvent>(_uploadPlants);
    on<LoadPlantsEvent>(_loadPlants);
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
      final plants = await plantRepository.fetchPlants();
      emit(PlantLoaded(plants));
    } catch (e) {
      emit(PlantError(e.toString()));
    }
  }
}
