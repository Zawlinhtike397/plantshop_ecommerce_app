// // // //=================

// // // import 'package:flutter/material.dart';
// // // import 'package:plantify_plantshop_project/common/widgets/icon/cart_icon_btn_widget.dart';
// // // import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
// // // import 'package:plantify_plantshop_project/common/widgets/listView/address_listview.dart';
// // // import 'package:plantify_plantshop_project/features/plant_shop/checkout/widgets/checkout_bottom_sheet.dart';
// // // import 'package:plantify_plantshop_project/features/plant_shop/checkout/widgets/payment_method_list_view.dart';

// // // class CheckoutScreen extends StatefulWidget {
// // //   double subTotalValue;
// // //   double totalValue;
// // //   num totalQuantityValue;

// // //   CheckoutScreen({
// // //     super.key,
// // //     required this.subTotalValue,
// // //     required this.totalValue,
// // //     required this.totalQuantityValue,
// // //   });

// // //   @override
// // //   State<CheckoutScreen> createState() => _CheckoutScreenState();
// // // }

// // // class _CheckoutScreenState extends State<CheckoutScreen> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return SafeArea(
// // //       top: false,
// // //       child: Scaffold(
// // //         appBar: AppBar(
// // //           title: Text(
// // //             'Checkout',
// // //             style: Theme.of(context).textTheme.titleLarge!.copyWith(
// // //               fontSize: 20.0,
// // //               fontWeight: FontWeight.normal,
// // //             ),
// // //           ),
// // //           backgroundColor: Colors.transparent,
// // //           centerTitle: true,
// // //           actions: [CartIconBtnWidget()],
// // //         ),
// // //         body: SingleChildScrollView(
// // //           child: Column(
// // //             children: [
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   spacing: 25.0,
// // //                   children: [
// // //                     Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       spacing: 20.0,
// // //                       children: [
// // //                         HeadingWidget(name: 'Shipping to'),

// // //                         SizedBox(height: 200, child: AddressListview()),
// // //                       ],
// // //                     ),

// // //                     HeadingWidget(name: 'Payment Method'),
// // //                     PaymentMethodListView(),
// // //                   ],
// // //                 ),
// // //               ),

// // //               CheckoutBottomSheet(
// // //                 subTotalValue: widget.subTotalValue,
// // //                 totalValue: widget.totalValue,
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // // ========================//
// // // import 'package:flutter/material.dart';
// // // import 'package:plantify_plantshop_project/utils/constants/colors.dart';
// // // import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

// // // class PaymentMethodListView extends StatefulWidget {
// // //   const PaymentMethodListView({super.key});

// // //   @override
// // //   State<PaymentMethodListView> createState() => _PaymentMethodListViewState();
// // // }

// // // class _PaymentMethodListViewState extends State<PaymentMethodListView> {
// // //   List<String> paymentOptions = [
// // //     'CB Pay',
// // //     'Aya Pay',
// // //     'KBZ pay',
// // //     'WaveMoney',
// // //     'CB Pay',
// // //     'Aya Pay',
// // //     'KBZ pay',
// // //     'WaveMoney',
// // //   ];
// // //   late String _selectedPaymentOption;
// // //   List<String> paymentImages = [
// // //     ImageStrings.cbPayLogo,
// // //     ImageStrings.ayaPayLogo,
// // //     ImageStrings.kbzPayLogo,
// // //     ImageStrings.waveMoneyLogo,
// // //     ImageStrings.cbPayLogo,
// // //     ImageStrings.ayaPayLogo,
// // //     ImageStrings.kbzPayLogo,
// // //     ImageStrings.waveMoneyLogo,
// // //   ];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _selectedPaymentOption = paymentOptions[0];
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //       // decoration: BoxDecoration(
// // //       //   color: Theme.of(context).brightness == Brightness.dark
// // //       //       ? AppColor.darkerGrey
// // //       //       : Colors.white,
// // //       // ),
// // //       child: ListView.separated(
// // //         shrinkWrap: true,
// // //         physics: NeverScrollableScrollPhysics(),
// // //         itemCount: paymentOptions.length,
// // //         itemBuilder: (context, index) {
// // //           return Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //             children: [
// // //               Row(
// // //                 spacing: 15.0,
// // //                 children: [
// // //                   Image.asset(paymentImages[index], width: 70),
// // //                   Text(
// // //                     paymentOptions[index],
// // //                     style: Theme.of(context).textTheme.bodySmall!.copyWith(
// // //                       fontSize: 14,
// // //                       fontWeight: FontWeight.w500,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //               Radio(
// // //                 value: paymentOptions[index],
// // //                 groupValue: _selectedPaymentOption,
// // //                 onChanged: (value) {
// // //                   setState(() {
// // //                     _selectedPaymentOption = value!;
// // //                   });
// // //                 },
// // //               ),
// // //             ],
// // //           );
// // //         },
// // //         separatorBuilder: (BuildContext context, int index) {
// // //           return SizedBox(height: 12);
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // // ==========================//
// // // import 'package:bloc/bloc.dart';
// // // import 'package:equatable/equatable.dart';
// // // import 'package:plantify_plantshop_project/data/repositories/discount_repository.dart';
// // // import 'package:plantify_plantshop_project/features/plant_shop/discount/model/discount_model.dart';
// // // import 'package:plantify_plantshop_project/utils/constants/enums.dart';

// // // part 'discount_event.dart';
// // // part 'discount_state.dart';

// // // class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
// // //   final DiscountRepository discountRepository;

// // //   DiscountBloc({required this.discountRepository}) : super(DiscountInitial()) {
// // //     on<FetchDiscounts>(_fetchDiscounts);
// // //     on<UploadDiscounts>(_uploadDiscounts);
// // //     on<ApplyCoupon>(_applyCoupon);
// // //   }

// // //   Future<void> _fetchDiscounts(
// // //     FetchDiscounts event,
// // //     Emitter<DiscountState> emit,
// // //   ) async {
// // //     try {
// // //       emit(DiscountLoading());

// // //       final discounts = await discountRepository.fetchDiscounts();

// // //       emit(DiscountLoaded(discounts));
// // //     } catch (e) {
// // //       emit(DiscountError(e.toString()));
// // //     }
// // //   }

// // //   Future<void> _uploadDiscounts(
// // //     UploadDiscounts event,
// // //     Emitter<DiscountState> emit,
// // //   ) async {
// // //     try {
// // //       emit(DiscountUploading());

// // //       await discountRepository.uploadDiscounts();

// // //       emit(DiscountUploaded());
// // //     } catch (e) {
// // //       emit(DiscountError(e.toString()));
// // //     }
// // //   }

// // //   Future<void> _applyCoupon(
// // //     ApplyCoupon event,
// // //     Emitter<DiscountState> emit,
// // //   ) async {
// // //     try {
// // //       final currentState = state;

// // //       if (currentState is! DiscountLoaded) return;

// // //       /// 1. Get discount by code
// // //       final discount = await discountRepository.getDiscountByCode(event.code);

// // //       if (discount == null) {
// // //         emit(
// // //           currentState.copyWith(
// // //             status: DiscountStatus.error,
// // //             message: "Invalid coupon code",
// // //           ),
// // //         );
// // //         return;
// // //       }

// // //       /// 2. Validate coupon
// // //       final now = DateTime.now();

// // //       if (!discount.isActive) {
// // //         emit(
// // //           currentState.copyWith(
// // //             status: DiscountStatus.error,
// // //             message: "Coupon is inactive",
// // //           ),
// // //         );
// // //         return;
// // //       }

// // //       if (now.isAfter(discount.validUntil)) {
// // //         emit(
// // //           currentState.copyWith(
// // //             status: DiscountStatus.error,
// // //             message: "Coupon expired",
// // //           ),
// // //         );
// // //         return;
// // //       }

// // //       if (event.cartTotal < discount.minAmount) {
// // //         emit(
// // //           currentState.copyWith(
// // //             status: DiscountStatus.error,
// // //             message: "Minimum amount is ${discount.minAmount} MMK",
// // //           ),
// // //         );
// // //         return;
// // //       }

// // //       final hasUsedAnyCoupon = await discountRepository.hasUserUsedAnyCoupon(
// // //         event.userId,
// // //       );

// // //       final isFirstTimeUser = !hasUsedAnyCoupon;

// // //       if (discount.firstTimeOnly && !isFirstTimeUser) {
// // //         emit(
// // //           currentState.copyWith(
// // //             status: DiscountStatus.error,
// // //             message: "Only for first-time users",
// // //           ),
// // //         );
// // //         return;
// // //       }

// // //       final alreadyUsed = await discountRepository.hasUserUsedCoupon(
// // //         userId: event.userId,
// // //         code: event.code,
// // //       );

// // //       if (alreadyUsed) {
// // //         emit(
// // //           currentState.copyWith(
// // //             status: DiscountStatus.error,
// // //             message: "You already used this coupon",
// // //           ),
// // //         );
// // //         return;
// // //       }

// // //       final discountAmount = (event.cartTotal * discount.percentage) / 100;

// // //       final newTotal = event.cartTotal - discountAmount;

// // //       print('newTotal is $newTotal');

// // //       /// 5. Save usage
// // //       // await discountRepository.saveCouponUsage(
// // //       //   userId: event.userId,
// // //       //   code: event.code,
// // //       // );

// // //       // final cartRepo = CartRepository();

// // //       // cartRepo.saveCoupon(
// // //       //   AppliedCouponModel(code: discount.code, discountAmount: discountAmount),
// // //       // );

// // //       emit(
// // //         currentState.copyWith(
// // //           status: DiscountStatus.success,
// // //           message: "Coupon applied",
// // //           discountAmount: discountAmount,
// // //           newTotal: newTotal,
// // //           appliedDiscount: discount,
// // //         ),
// // //       );
// // //     } catch (e) {
// // //       if (state is DiscountLoaded) {
// // //         emit(
// // //           (state as DiscountLoaded).copyWith(
// // //             status: DiscountStatus.error,
// // //             message: e.toString(),
// // //           ),
// // //         );
// // //       }
// // //     }
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:plantify_plantshop_project/features/plant_shop/order/order_detail_screen.dart';

// // // class OrderCard extends StatelessWidget {
// // //   final String title, date, name, price, status;
// // //   final Color color;

// // //   const OrderCard({
// // //     super.key,
// // //     required this.title,
// // //     required this.date,
// // //     required this.name,
// // //     required this.price,
// // //     required this.status,
// // //     required this.color,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(
// // //             builder: (context) {
// // //               return OrderDetailScreen();
// // //             },
// // //           ),
// // //         );
// // //       },
// // //       child: Container(
// // //         margin: const EdgeInsets.only(bottom: 12),
// // //         padding: const EdgeInsets.all(12),
// // //         decoration: BoxDecoration(
// // //           border: Border.all(color: Colors.grey.shade300),
// // //           borderRadius: BorderRadius.circular(12),
// // //         ),
// // //         child: Column(
// // //           children: [
// // //             /// Top
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 const Text("ID: 65JHG1"),
// // //                 Container(
// // //                   padding: const EdgeInsets.symmetric(
// // //                     horizontal: 10,
// // //                     vertical: 4,
// // //                   ),
// // //                   decoration: BoxDecoration(
// // //                     color: color,
// // //                     borderRadius: BorderRadius.circular(6),
// // //                   ),
// // //                   child: Text(
// // //                     status,
// // //                     style: const TextStyle(color: Colors.white, fontSize: 12),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),

// // //             const Divider(),

// // //             /// Middle
// // //             Row(
// // //               children: [
// // //                 Container(width: 50, height: 50, color: Colors.grey.shade300),
// // //                 const SizedBox(width: 10),
// // //                 Expanded(
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         title,
// // //                         style: const TextStyle(fontWeight: FontWeight.bold),
// // //                       ),
// // //                       Text(date),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),

// // //             const Divider(),

// // //             /// Bottom
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Text(name),
// // //                 Text(
// // //                   price,
// // //                   style: const TextStyle(fontWeight: FontWeight.bold),
// // //                 ),
// // //               ],
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // =================//

// // // import 'package:flutter/material.dart';
// // // import 'package:plantify_plantshop_project/features/plant_shop/order/widgets/order_card.dart';
// // // import 'package:plantify_plantshop_project/utils/constants/colors.dart';

// // // class MyOrdersScreen extends StatelessWidget {
// // //   const MyOrdersScreen({super.key});

// // //   Widget _tab(String text, bool active) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// // //       decoration: BoxDecoration(
// // //         color: active ? Colors.green : Colors.grey.shade200,
// // //         borderRadius: BorderRadius.circular(8),
// // //         border: Border.all(color: AppColor.primary),
// // //       ),
// // //       child: Text(
// // //         text,
// // //         style: TextStyle(color: active ? Colors.white : Colors.black54),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text("My Orders"), centerTitle: true),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           children: [
// // //             const SizedBox(height: 15),

// // //             SizedBox(
// // //               height: 35,
// // //               child: ListView.separated(
// // //                 scrollDirection: Axis.horizontal,
// // //                 itemBuilder: (BuildContext context, int index) {
// // //                   return _tab("All", false);
// // //                 },
// // //                 separatorBuilder: (BuildContext context, int index) {
// // //                   return SizedBox(width: 10);
// // //                 },
// // //                 itemCount: 5,
// // //               ),
// // //             ),
// // //             const SizedBox(height: 15),

// // //             Expanded(
// // //               child: ListView(
// // //                 children: [
// // //                   OrderCard(
// // //                     title: "Snake Plant",
// // //                     date: "6 Jan, 2025",
// // //                     name: "Sarah",
// // //                     price: "\$32.43",
// // //                     status: "Pending",
// // //                     color: Colors.blueGrey,
// // //                   ),
// // //                   OrderCard(
// // //                     title: "Jad Plant",
// // //                     date: "6 Feb, 2025",
// // //                     name: "Janna",
// // //                     price: "\$66.73",
// // //                     status: "Shipping",
// // //                     color: Colors.orange,
// // //                   ),
// // //                   OrderCard(
// // //                     title: "Snake Plant",
// // //                     date: "6 Jan, 2025",
// // //                     name: "Sarah",
// // //                     price: "\$32.43",
// // //                     status: "Processing",
// // //                     color: Colors.cyan,
// // //                   ),
// // //                   OrderCard(
// // //                     title: "Snake Plant",
// // //                     date: "6 Jan, 2025",
// // //                     name: "Sarah",
// // //                     price: "\$32.43",
// // //                     status: "Delivered",
// // //                     color: Colors.green,
// // //                   ),
// // //                   OrderCard(
// // //                     title: "Snake Plant",
// // //                     date: "6 Jan, 2025",
// // //                     name: "Sarah",
// // //                     price: "\$32.43",
// // //                     status: "Canceled",
// // //                     color: Colors.red,
// // //                   ),
// // //                 ],
// // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// import 'package:bloc/bloc.dart';
// import 'package:plantify_plantshop_project/data/repositories/authentication_repository.dart';
// import 'package:plantify_plantshop_project/data/repositories/cart_repository.dart';
// import 'package:plantify_plantshop_project/data/repositories/user_repository.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// part 'app_event.dart';
// part 'app_state.dart';

// class AppBloc extends Bloc<AppEvent, AppState> {
//   final AuthRepository authRepository;
//   final UserRepository userRepository;
//   final CartRepository cartRepository;

//   AppBloc({
//     required this.authRepository,
//     required this.userRepository,
//     required this.cartRepository,
//   }) : super(AppInitial()) {
//     on<AppStarted>(_onAppStarted);
//     on<AppOnboardingCompleted>(_onOnboardingCompleted);
//     on<AuthStatusChanged>(_onAuthStatusChanged);
//   }

//   Future<void> _handleAuthState(Emitter<AppState> emit) async {
//     await Future.delayed(const Duration(milliseconds: 150));

//     final loggedIn = await authRepository.isLoggedIn();
//     if (loggedIn) {
//       await userRepository.addOrUpdateUserData();

//       final userId = Supabase.instance.client.auth.currentUser!.id;

//       await cartRepository.initForUser(userId);

//       emit(AppAuthenticated());
//     } else {
//       emit(AppUnauthenticated());
//     }
//   }

//   Future<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
//     final onboarded = await authRepository.isOnboardingCompleted();

//     if (!onboarded) {
//       emit(AppOnboarding());
//       return;
//     }

//     await _handleAuthState(emit);
//   }

//   Future<void> _onOnboardingCompleted(
//     AppOnboardingCompleted event,
//     Emitter<AppState> emit,
//   ) async {
//     await authRepository.completeOnboarding();

//     await _handleAuthState(emit);
//   }

//   Future<void> _onAuthStatusChanged(
//     AuthStatusChanged event,
//     Emitter<AppState> emit,
//   ) async {
//     await _handleAuthState(emit);
//   }
// }
