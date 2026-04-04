import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/common/plant_info/bloc/plant_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/container/search_container.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/grid_view_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/plant_card.dart';
import 'package:plantify_plantshop_project/features/plant_shop/search_products/widgets/filter_sheet.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PlantBloc>().add(
      const LoadPlantsEvent(category: 'All', searchQuery: ''),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColor.darkerGrey
          : Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return const FilterSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: SearchContainer(
          searchBarText: 'Search plants',
          icon: Iconsax.search_normal,
          openSearchPageOnTap: false,
          showBorder: true,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<PlantBloc, PlantState>(
            builder: (context, state) {
              if (state is PlantLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is PlantError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              if (state is PlantLoaded) {
                if (state.plants.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No plants found',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }

                return SliverMainAxisGroup(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ), //need to run for testing.
                      sliver: GridViewWidget(
                        itemCount: state.plants.length,
                        crossAxisCount: 2,
                        itemBuilder: (context, index) {
                          return PlantCard(plant: state.plants[index]);
                        },
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 20)),

                    SliverToBoxAdapter(
                      child: Center(
                        child: state.hasReachedMax
                            ? const Text("No more data")
                            : state.isLoadingMore
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<PlantBloc>().add(
                                      LoadMorePlantsEvent(),
                                    );
                                  },
                                  child: const Text("Load More"),
                                ),
                              ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  ],
                );
              }

              return const SliverToBoxAdapter(child: SizedBox());
            },
          ),
        ],
      ),
    );
  }
}
