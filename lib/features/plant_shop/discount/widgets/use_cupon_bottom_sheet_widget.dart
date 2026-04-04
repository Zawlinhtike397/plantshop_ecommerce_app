import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantify_plantshop_project/common/user/bloc/user_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/list/unordered_list.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/bloc/cart_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/bloc/discount_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/model/discount_model.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/enums.dart';

class UseCuponBottomSheetWidget extends StatelessWidget {
  final DiscountModel discount;

  const UseCuponBottomSheetWidget({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => SafeArea(
        child: BlocConsumer<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is DiscountLoaded) {
              if (state.status == DiscountStatus.success) {
                context.read<CartBloc>().add(
                  ApplyDiscountEvent(
                    discountAmount: state.discountAmount!,
                    code: state.appliedDiscount!.code,
                  ),
                );

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Success'),
                    content: Text(
                      'Coupon applied! New total: ${state.newTotal}',
                    ),
                  ),
                );
              }

              if (state.status == DiscountStatus.error) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message ?? ''),
                  ),
                );
              }
            }
          },
          builder: (context, state) => SingleChildScrollView(
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
                                  discount.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
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
                                            text: discount.code,
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
                                            text: '${discount.percentage}%',
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
                                            text:
                                                'Buy for at least ${discount.minAmount} or more',
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
                                            text:
                                                '${discount.validUntil.day}.${discount.validUntil.month}.${discount.validUntil.year}',
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
                                UnorderedList(texts: discount.rules),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final userState = context.read<UserBloc>().state;
                        final cartState = context.read<CartBloc>().state;

                        if (userState is! UserLoaded ||
                            cartState is! CartLoaded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Something went wrong"),
                            ),
                          );
                          return;
                        }

                        final userId = userState.user.id;
                        final cartTotal = cartState.total;

                        context.read<DiscountBloc>().add(
                          ApplyCoupon(
                            userId: userId,
                            code: discount.code,
                            cartTotal: cartTotal,
                          ),
                        );
                      },
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
      ),
    );
  }
}
