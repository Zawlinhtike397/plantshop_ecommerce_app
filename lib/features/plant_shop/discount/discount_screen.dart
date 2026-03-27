import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/bloc/discount_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/discount/widgets/discount_card.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DiscountBloc>().add(FetchDiscounts());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Discount Offers',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<DiscountBloc, DiscountState>(
          builder: (context, state) {
            if (state is DiscountLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DiscountLoaded) {
              final discounts = state.discounts;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                itemCount: discounts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final discount = discounts[index];

                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeadingWidget(name: 'Discount Coupons'),
                        const SizedBox(height: 20),
                        DiscountCard(discount: discount),
                      ],
                    );
                  }

                  return DiscountCard(discount: discount);
                },
              );
            }

            if (state is DiscountError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
