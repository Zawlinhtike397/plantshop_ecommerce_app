part of 'favourites_bloc.dart';

sealed class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavouritesEvent extends FavouritesEvent {}

final class ToggleFavouriteEvent extends FavouritesEvent {
  final int plantId;

  const ToggleFavouriteEvent(this.plantId);

  @override
  List<Object> get props => [plantId];
}
