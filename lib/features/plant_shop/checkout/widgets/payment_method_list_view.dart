import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class PaymentMethodListView extends StatefulWidget {
  const PaymentMethodListView({super.key});

  @override
  State<PaymentMethodListView> createState() => _PaymentMethodListViewState();
}

class _PaymentMethodListViewState extends State<PaymentMethodListView> {
  List<String> paymentOptions = ['CB Pay', 'Aya Pay', 'KBZ pay', 'WaveMoney'];
  late String _selectedPaymentOption;
  List<String> paymentImages = [
    ImageStrings.cbPayLogo,
    ImageStrings.ayaPayLogo,
    ImageStrings.kbzPayLogo,
    ImageStrings.waveMoneyLogo,
  ];

  @override
  void initState() {
    super.initState();
    _selectedPaymentOption = paymentOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        shrinkWrap: true,

        itemCount: paymentOptions.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 15.0,
                children: [
                  Image.asset(paymentImages[index], width: 70),
                  Text(
                    paymentOptions[index],
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Radio(
                value: paymentOptions[index],
                groupValue: _selectedPaymentOption,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentOption = value!;
                  });
                },
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 12);
        },
      ),
    );
  }
}
