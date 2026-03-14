import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/plant_info/bloc/plant_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/product/custom_filter_chip.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/grid_view_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/plant_card.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/top_header_widget.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

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
    context.read<PlantBloc>().add(LoadPlantsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: BlocBuilder<PlantBloc, PlantState>(
          builder: (context, state) {
            if (state is PlantLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlantLoaded) {
              final plants = state.plants;
              final categories = [
                'All',
                ...plants.map((plant) => plant.category).toSet(),
              ];

              final filteredPlants = selectedCategory == 'All'
                  ? plants
                  : plants
                        .where((p) => p.category == selectedCategory)
                        .toList();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    TopHeaderWidget(),

                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (categories.length > 1) ...[
                            HeadingWidget(name: 'Categories'),
                            SizedBox(height: 15.0),
                            SizedBox(
                              height: 40,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  final category = categories[index];

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = category;
                                      });
                                    },
                                    child: CustomFilterChip(
                                      label: category,
                                      isSelected: selectedCategory == category,
                                      showColor: true,
                                      showBorder: true,
                                      borderColor: AppColor.primary.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                          ],
                          if (filteredPlants.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 80),
                                child: Text('No plant data found'),
                              ),
                            )
                          else
                            GridViewWidget(
                              itemCount: filteredPlants.length,
                              crossAxisCount: 2,
                              itemBuilder: (context, index) {
                                return PlantCard(plant: filteredPlants[index]);
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PlantError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
