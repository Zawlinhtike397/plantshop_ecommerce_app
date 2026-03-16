part of 'favourites_bloc.dart';

sealed class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

final class FavouritesInitial extends FavouritesState {}

class FavouriteLoading extends FavouritesState {}

class FavouriteLoaded extends FavouritesState {
  final List<int> favouriteIds;

  const FavouriteLoaded(this.favouriteIds);

  @override
  List<Object> get props => [favouriteIds];
}

class FavouriteError extends FavouritesState {
  final String message;

  const FavouriteError(this.message);
}
