import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plantify_plantshop_project/features/plant_shop/favourite/repository/favourite_repository.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final FavouriteRepository repository;
  FavouritesBloc({required this.repository}) : super(FavouritesInitial()) {
    on<LoadFavouritesEvent>(_loadFavourites);
    on<ToggleFavouriteEvent>(_toggleFavourite);
  }

  Future<void> _loadFavourites(
    LoadFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      emit(FavouriteLoading());

      final ids = await repository.getFavouriteIds();

      emit(FavouriteLoaded(ids));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> _toggleFavourite(
    ToggleFavouriteEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    await repository.toggleFavourite(event.plantId);

    final ids = await repository.getFavouriteIds();

    emit(FavouriteLoaded(ids));
  }
}
