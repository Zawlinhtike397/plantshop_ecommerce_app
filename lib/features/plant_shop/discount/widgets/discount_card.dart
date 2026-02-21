import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:plantify_plantshop_project/common/widgets/list/unordered_list.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/widgets/use_cuppon_bottom_sheet_widget.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    void openUseCuponBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColor.darkerGrey
            : Theme.of(context).scaffoldBackgroundColor,
        builder: (context) {
          return UseCuponBottomSheetWidget();
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.borderColor),
        borderRadius: BorderRadius.circular(12.0),
        color: isDarkMode ? AppColor.darkerGrey : Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Column(
        spacing: 10.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(Iconsax.tag, color: AppColor.primary, size: 40),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.0,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            'Buy for 20k for first time',
                            style: Theme.of(context).textTheme.bodyLarge!,
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: 'Code: ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: <TextSpan>[
                                TextSpan(
                                  text: '1ST2D',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(text: ' (30%)'),
                              ],
                            ),
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: 'Req: ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Buy for at least 20k or more',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'Copy Code',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: AppColor.primary),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Expire In: 24.4.2026'),
              InkWell(
                onTap: () {
                  openUseCuponBottomSheet(context);
                },
                child: Text(
                  'Use',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: AppColor.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
