import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/plant_info/bloc/plant_bloc.dart';
import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/common/widgets/product/custom_filter_chip.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/grid_view_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/plant_card.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/top_header_widget.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/popups/category_chip_shimmer.dart';
import 'package:plantify_plantshop_project/utils/popups/plant_card_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    final state = context.read<PlantBloc>().state;
    if (state is! PlantLoaded) {
      context.read<PlantBloc>().add(LoadPlantsEvent(category: 'All'));
    }
  }

  List<Widget> buildPlantGrid({
    required PlantState state,
    List<PlantModel>? filteredPlants,
  }) {
    if (state is PlantLoading) {
      return [
        GridViewWidget(
          crossAxisCount: 2,
          itemCount: 6,
          itemBuilder: (_, __) => const PlantCardShimmer(),
        ),
      ];
    }

    if (state is PlantError) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        ),
      ];
    }

    if (filteredPlants == null || filteredPlants.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text('No plant data found'),
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        sliver: GridViewWidget(
          crossAxisCount: 2,
          itemCount: filteredPlants.length,
          itemBuilder: (context, index) =>
              PlantCard(plant: filteredPlants[index]),
        ),
      ),

      const SliverToBoxAdapter(child: SizedBox(height: 20)),

      SliverToBoxAdapter(
        child: Center(
          child: state is! PlantLoaded
              ? const SizedBox()
              : state.hasReachedMax
              ? const Text("No more data")
              : state.isLoadingMore
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<PlantBloc>().add(LoadMorePlantsEvent());
                    },
                    child: const Text("Load More"),
                  ),
                ),
        ),
      ),

      const SliverToBoxAdapter(child: SizedBox(height: 40)),
    ];
  }

  Widget buildCategoryChips({required PlantState state}) {
    if (state is PlantLoading) {
      return SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, __) => const CategoryChipShimmer(),
        ),
      );
    }

    final categories = (state is PlantLoaded) ? state.categories : ['All'];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });

              context.read<PlantBloc>().add(
                LoadPlantsEvent(category: category),
              );
            },
            child: CustomFilterChip(
              label: category,
              isSelected: selectedCategory == category,
              showColor: true,
              showBorder: true,
              borderColor: AppColor.primary.withValues(alpha: 0.5),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: BlocBuilder<PlantBloc, PlantState>(
          builder: (context, state) {
            final filteredPlants = (state is PlantLoaded) ? state.plants : null;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: TopHeaderWidget()),

                SliverPadding(
                  padding: const EdgeInsets.all(20.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      HeadingWidget(name: 'All Plants'),
                      const SizedBox(height: 15),
                      buildCategoryChips(state: state),
                      const SizedBox(height: 20),
                    ]),
                  ),
                ),

                ...buildPlantGrid(state: state, filteredPlants: filteredPlants),
              ],
            );
          },
        ),
      ),
    );
  }
}
