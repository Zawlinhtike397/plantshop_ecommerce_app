import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/plant_shop/checkout/model/payment_method_model.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class PaymentMethodSliverList extends StatefulWidget {
  final Function(String)? onSelected;
  final String? selectedId;

  const PaymentMethodSliverList({super.key, this.onSelected, this.selectedId});

  @override
  State<PaymentMethodSliverList> createState() =>
      _PaymentMethodSliverListState();
}

class _PaymentMethodSliverListState extends State<PaymentMethodSliverList> {
  final List<PaymentModel> paymentMethods = [
    PaymentModel(id: 'cb_1', name: 'CB Pay', image: ImageStrings.cbPayLogo),
    PaymentModel(id: 'aya_1', name: 'Aya Pay', image: ImageStrings.ayaPayLogo),
    PaymentModel(id: 'kbz_1', name: 'KBZ Pay', image: ImageStrings.kbzPayLogo),
    PaymentModel(
      id: 'wave_1',
      name: 'Wave Money',
      image: ImageStrings.waveMoneyLogo,
    ),
    PaymentModel(id: 'cb_2', name: 'CB Pay', image: ImageStrings.cbPayLogo),
    PaymentModel(id: 'aya_2', name: 'Aya Pay', image: ImageStrings.ayaPayLogo),
    PaymentModel(id: 'kbz_2', name: 'KBZ Pay', image: ImageStrings.kbzPayLogo),
    PaymentModel(
      id: 'wave_2',
      name: 'Wave Money',
      image: ImageStrings.waveMoneyLogo,
    ),
    PaymentModel(id: 'cb_3', name: 'CB Pay', image: ImageStrings.cbPayLogo),
    PaymentModel(id: 'aya_3', name: 'Aya Pay', image: ImageStrings.ayaPayLogo),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   selectedPaymentId = paymentMethods.first.id;
  // }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final payment = paymentMethods[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(payment.image, width: 60),
                    const SizedBox(width: 15),
                    Text(
                      payment.name,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                /// Radio Button
                Radio<String>(
                  value: payment.id,
                  groupValue: widget.selectedId,
                  onChanged: (value) {
                    if (value != null) {
                      widget.onSelected?.call(value);
                    }
                  },
                ),
              ],
            ),
          );
        }, childCount: paymentMethods.length),
      ),
    );
  }
}
