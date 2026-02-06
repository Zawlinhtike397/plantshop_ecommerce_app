import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/category_chip.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_title.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/widgets/grid_view_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/widgets/plant_card.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/widgets/top_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                          CategoryChip(label: 'All', isSelected: true),
                          CategoryChip(label: 'Popular'),
                          CategoryChip(label: 'Indoor'),
                          CategoryChip(label: 'Outdoor'),
                          CategoryChip(label: 'Garden'),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GridViewWidget(
                      itemCount: 6,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        return const PlantCard();
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
