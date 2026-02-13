import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/custom_filter_chip.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_title.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/grid_view_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/plant_card.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/top_header_widget.dart';
import 'package:plantify_plantshop_project/plant_data.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSelected = true;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopHeaderWidget(),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductTitle(name: 'Categories'),
                    SizedBox(height: 15.0),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CustomFilterChip(
                            label: 'All',
                            isSelected: true,
                            showColor: true,
                            showBorder: true,
                            borderColor: AppColor.primary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          CustomFilterChip(
                            label: 'Indoor',
                            showColor: true,
                            showBorder: true,
                          ),
                          CustomFilterChip(
                            label: 'Outdoor',
                            showColor: true,
                            showBorder: true,
                          ),
                          CustomFilterChip(
                            label: 'Garden',
                            showColor: true,
                            showBorder: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GridViewWidget(
                      itemCount: plants.length,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        return PlantCard(plant: plants[index]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
