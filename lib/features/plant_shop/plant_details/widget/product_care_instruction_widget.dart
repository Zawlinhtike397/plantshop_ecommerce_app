import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_name_text.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class ProductCareInstructionWidget extends StatelessWidget {
  final Map<String, Object> plantData;
  const ProductCareInstructionWidget({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    final careGuide = plantData['careGuide'] as Map<String, dynamic>?;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductText(name: 'Care Instruction', overflow: TextOverflow.ellipsis),
        SizedBox(height: 10),
        if (careGuide != null)
          Column(
            children: careGuide.values.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.eco_outlined,
                      size: 18,
                      color: AppColor.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'],
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['description'],
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        if (careGuide != null) SizedBox(height: 10),
      ],
    );
  }
}
