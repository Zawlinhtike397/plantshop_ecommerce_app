import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/favourite/bloc/favourites_bloc.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class FavouriteIcon extends StatelessWidget {
  final int plantId;

  const FavouriteIcon({super.key, required this.plantId});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<FavouritesBloc, FavouritesState>(
      builder: (context, state) {
        bool isFavourite = false;

        if (state is FavouriteLoaded) {
          isFavourite = state.favouriteIds.contains(plantId);
        }

        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode ? AppColor.darkBackground : Colors.grey.shade200,
          ),
          child: IconButton(
            onPressed: () {
              context.read<FavouritesBloc>().add(ToggleFavouriteEvent(plantId));
            },
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: isFavourite ? AppColor.primary : Colors.grey,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
