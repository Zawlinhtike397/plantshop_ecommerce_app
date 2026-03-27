import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/bloc/discount_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/discount_model.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/widgets/use_cuppon_bottom_sheet_widget.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class DiscountCard extends StatelessWidget {
  final DiscountModel discount;
  const DiscountCard({super.key, required this.discount});

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
          return BlocProvider.value(
            value: context.read<DiscountBloc>(),
            child: UseCuponBottomSheetWidget(discount: discount),
          );
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
                            discount.title,
                            style: Theme.of(context).textTheme.bodyLarge!,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: 'Code: ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: discount.code,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                    TextSpan(
                                      text: ' (${discount.percentage}%)',
                                    ),
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(
                                    ClipboardData(text: discount.code),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Copied: ${discount.code}'),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Copy Code',
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: AppColor.primary),
                                ),
                              ),
                            ],
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: 'Req: ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'Buy for at least ${discount.minAmount} or more',
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
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expire In: ${discount.validUntil.day}.${discount.validUntil.month}.${discount.validUntil.year}',
              ),
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
