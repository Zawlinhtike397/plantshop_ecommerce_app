import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/custom_filter_chip.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  String selectedSort = '';

  final sortOptions = [
    'Price (Low/High)',
    'Price (High/Low)',
    'Newest first',
    'Sale (High/Low )',
    'Sale (Low/High)',
    'Name',
  ];

  final categories = ['Indoor', 'Outdoor', 'Gardening', 'Succulent plants'];

  final selectedCategories = <String>{};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSort = '';
                        selectedCategories.clear();
                      });
                    },
                    child: const Text(
                      "CLEAR ALL",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    "REFINE RESULTS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              const Text(
                "Sort by",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              ...sortOptions.map((e) {
                return RadioListTile(
                  value: e,
                  groupValue: selectedSort,
                  onChanged: (value) {
                    setState(() => selectedSort = value!);
                  },
                  title: Text(e),
                  activeColor: AppColor.primary,
                );
              }),
              const SizedBox(height: 20),

              const Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: categories.map((category) {
                  final selected = selectedCategories.contains(category);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected
                            ? selectedCategories.remove(category)
                            : selectedCategories.add(category);
                      });
                    },
                    child: CustomFilterChip(
                      label: category,
                      isSelected: selected,
                      showColor: true,
                      showBorder: true,
                      borderColor: selected
                          ? AppColor.primary.withValues(alpha: 0.5)
                          : AppColor.borderColor,
                      borderRadius: 8,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Apply Filters"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
