import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/plant_info/bloc/plant_bloc.dart';
import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/common/widgets/loaders/animation_loader.dart';
import 'package:plantify_plantshop_project/features/plant_shop/favourite/bloc/favourites_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/grid_view_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/plant_card.dart';
import 'package:plantify_plantshop_project/features/plant_shop/navigation/navigation_cubit.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavouritesBloc>().add(LoadFavouritesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: BlocBuilder<PlantBloc, PlantState>(
              builder: (context, plantState) {
                if (plantState is PlantLoaded) {
                  return BlocBuilder<FavouritesBloc, FavouritesState>(
                    builder: (context, favState) {
                      List<PlantModel> favouritePlants = [];

                      if (favState is FavouriteLoaded) {
                        favouritePlants = plantState.plants
                            .where((p) => favState.favouriteIds.contains(p.id))
                            .toList();
                      }

                      if (favState is FavouriteLoading ||
                          plantState is PlantLoading) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (favouritePlants.isEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: AnimationLoader(
                              headingText: 'Wishlist is empty!',
                              animation: ImageStrings.emptyAnimation,
                              smallText:
                                  'Add something that you wish to buy here',
                              showActionButton: true,
                              actionText: 'Add Products',
                              onPressed: () {
                                context.read<NavigationCubit>().changeIndex(0);
                              },
                            ),
                          ),
                        );
                      }

                      return GridViewWidget(
                        itemCount: favouritePlants.length,
                        crossAxisCount: 2,
                        itemBuilder: (context, index) {
                          final plant = favouritePlants[index];
                          return PlantCard(plant: plant);
                        },
                      );
                    },
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),
          ),
        ],
      ),
    );
  }
}
