import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/plant_info_bottom_sheet.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/product_care_instruction_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/product_category_text.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/product_detail_appbar.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/product_detail_image_slider.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/product_detail_text.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/product_stock_status.dart';

class PlantDetailsScreen extends StatefulWidget {
  final Map<String, Object> plant;
  const PlantDetailsScreen({super.key, required this.plant});

  @override
  State<PlantDetailsScreen> createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen> {
  final _controller = PageController();
  late List<Image> allImages;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            ProductDetailAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductDetailImageSlider(
                    controller: _controller,
                    plantData: widget.plant,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductDetailText(plantData: widget.plant),
                        const SizedBox(height: 20),

                        ProductCategoryText(plantData: widget.plant),
                        const SizedBox(height: 20),

                        ProductStockStatus(),
                        const SizedBox(height: 20),

                        ProductCareInstructionWidget(plantData: widget.plant),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PlantInfoBottomSheet(plantData: widget.plant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
