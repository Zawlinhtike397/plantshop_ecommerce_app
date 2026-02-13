import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/search/cubit/search_cubit.dart';
import 'package:plantify_plantshop_project/common/widgets/container/search_container.dart';
import 'package:plantify_plantshop_project/common/widgets/product/custom_filter_chip.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/app_filter_button.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/grid_view_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/plant_card.dart';
import 'package:plantify_plantshop_project/features/plant_shop/search_products/widgets/filter_sheet.dart';
import 'package:plantify_plantshop_project/plant_data.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
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
  void initState() {
    super.initState();
    context.read<SearchCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    final exampleFilters = [
      //   'Price (High/Low)',
      // 'Sale (High/Low )',
      'Name',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: SearchContainer(
          searchBarText: 'Search plants',
          icon: Icons.search,
          openSearchPageOnTap: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
          child: Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  spacing: 10.0,
                  children: [
                    AppFilterButton(
                      iconColorFilter: ColorFilter.mode(
                        AppColor.buttonPrimary,
                        BlendMode.srcIn,
                      ),
                      backgroundColor: Colors.transparent,
                      onTap: () {
                        _openFilterSheet(context);
                      },
                      showBorder: true,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: exampleFilters.length,

                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: CustomFilterChip(
                              label: exampleFilters[index],
                              showColor: false,
                              showBorder: true,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              BlocBuilder<SearchCubit, String>(
                builder: (context, query) {
                  final filteredPlants = query.isEmpty
                      ? plants
                      : plants.where((plant) {
                          final name = plant['name'].toString().toLowerCase();
                          return name.contains(query.toLowerCase().trim());
                        }).toList();

                  if (filteredPlants.isEmpty) {
                    return const Center(
                      child: Text(
                        'No plants found 🌱',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return GridViewWidget(
                    itemCount: filteredPlants.length,
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      return PlantCard(plant: filteredPlants[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
