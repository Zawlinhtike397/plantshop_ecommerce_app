import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/common/widgets/list/unordered_list.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class UseCuponBottomSheetWidget extends StatelessWidget {
  const UseCuponBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              spacing: 25.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Iconsax.tag, color: AppColor.primary, size: 40),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 25.0,
                        children: [
                          Column(
                            spacing: 20.0,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Buy for 20k for first time',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 7.0,
                                children: [
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Code: ',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '1ST2D',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Discount Percentage: ',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '30%',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Requirement: ',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Buy for at least 20k or more ',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Applies: ',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'all plants',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Valid Until: ',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '12 Dec 2025',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Column(
                            spacing: 20.0,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadingWidget(name: 'Rules'),
                              UnorderedList(
                                texts: [
                                  'You must use this code before  expire.',
                                  'This is only available for first purchase.',
                                  'This code can be applied in purchasing all plants.',

                                  'You must use this code before  expire.',
                                  'This is only available for first purchase.',
                                  'This code can be applied in purchasing all plants.',

                                  'You must use this code before  expire.',
                                  'This is only available for first purchase.',
                                  'This code can be applied in purchasing all plants.',

                                  'You must use this code before  expire.',
                                  'This is only available for first purchase.',
                                  'This code can be applied in purchasing all plants.',

                                  'You must use this code before  expire.',
                                  'This is only available for first purchase.',
                                  'This code can be applied in purchasing all plants.',
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                ///
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text('Use Cupon Code'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
