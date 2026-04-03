// //=================

// import 'package:flutter/material.dart';
// import 'package:plantify_plantshop_project/common/widgets/icon/cart_icon_btn_widget.dart';
// import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
// import 'package:plantify_plantshop_project/common/widgets/listView/address_listview.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/checkout/widgets/checkout_bottom_sheet.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/checkout/widgets/payment_method_list_view.dart';

// class CheckoutScreen extends StatefulWidget {
//   double subTotalValue;
//   double totalValue;
//   num totalQuantityValue;

//   CheckoutScreen({
//     super.key,
//     required this.subTotalValue,
//     required this.totalValue,
//     required this.totalQuantityValue,
//   });

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Checkout',
//             style: Theme.of(context).textTheme.titleLarge!.copyWith(
//               fontSize: 20.0,
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//           centerTitle: true,
//           actions: [CartIconBtnWidget()],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 25.0,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       spacing: 20.0,
//                       children: [
//                         HeadingWidget(name: 'Shipping to'),

//                         SizedBox(height: 200, child: AddressListview()),
//                       ],
//                     ),

//                     HeadingWidget(name: 'Payment Method'),
//                     PaymentMethodListView(),
//                   ],
//                 ),
//               ),

//               CheckoutBottomSheet(
//                 subTotalValue: widget.subTotalValue,
//                 totalValue: widget.totalValue,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ========================//
// import 'package:flutter/material.dart';
// import 'package:plantify_plantshop_project/utils/constants/colors.dart';
// import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

// class PaymentMethodListView extends StatefulWidget {
//   const PaymentMethodListView({super.key});

//   @override
//   State<PaymentMethodListView> createState() => _PaymentMethodListViewState();
// }

// class _PaymentMethodListViewState extends State<PaymentMethodListView> {
//   List<String> paymentOptions = [
//     'CB Pay',
//     'Aya Pay',
//     'KBZ pay',
//     'WaveMoney',
//     'CB Pay',
//     'Aya Pay',
//     'KBZ pay',
//     'WaveMoney',
//   ];
//   late String _selectedPaymentOption;
//   List<String> paymentImages = [
//     ImageStrings.cbPayLogo,
//     ImageStrings.ayaPayLogo,
//     ImageStrings.kbzPayLogo,
//     ImageStrings.waveMoneyLogo,
//     ImageStrings.cbPayLogo,
//     ImageStrings.ayaPayLogo,
//     ImageStrings.kbzPayLogo,
//     ImageStrings.waveMoneyLogo,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _selectedPaymentOption = paymentOptions[0];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // decoration: BoxDecoration(
//       //   color: Theme.of(context).brightness == Brightness.dark
//       //       ? AppColor.darkerGrey
//       //       : Colors.white,
//       // ),
//       child: ListView.separated(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: paymentOptions.length,
//         itemBuilder: (context, index) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 spacing: 15.0,
//                 children: [
//                   Image.asset(paymentImages[index], width: 70),
//                   Text(
//                     paymentOptions[index],
//                     style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               Radio(
//                 value: paymentOptions[index],
//                 groupValue: _selectedPaymentOption,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedPaymentOption = value!;
//                   });
//                 },
//               ),
//             ],
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return SizedBox(height: 12);
//         },
//       ),
//     );
//   }
// }

// ==========================//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:plantify_plantshop_project/data/repositories/discount_repository.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/discount/model/discount_model.dart';
// import 'package:plantify_plantshop_project/utils/constants/enums.dart';

// part 'discount_event.dart';
// part 'discount_state.dart';

// class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
//   final DiscountRepository discountRepository;

//   DiscountBloc({required this.discountRepository}) : super(DiscountInitial()) {
//     on<FetchDiscounts>(_fetchDiscounts);
//     on<UploadDiscounts>(_uploadDiscounts);
//     on<ApplyCoupon>(_applyCoupon);
//   }

//   Future<void> _fetchDiscounts(
//     FetchDiscounts event,
//     Emitter<DiscountState> emit,
//   ) async {
//     try {
//       emit(DiscountLoading());

//       final discounts = await discountRepository.fetchDiscounts();

//       emit(DiscountLoaded(discounts));
//     } catch (e) {
//       emit(DiscountError(e.toString()));
//     }
//   }

//   Future<void> _uploadDiscounts(
//     UploadDiscounts event,
//     Emitter<DiscountState> emit,
//   ) async {
//     try {
//       emit(DiscountUploading());

//       await discountRepository.uploadDiscounts();

//       emit(DiscountUploaded());
//     } catch (e) {
//       emit(DiscountError(e.toString()));
//     }
//   }

//   Future<void> _applyCoupon(
//     ApplyCoupon event,
//     Emitter<DiscountState> emit,
//   ) async {
//     try {
//       final currentState = state;

//       if (currentState is! DiscountLoaded) return;

//       /// 1. Get discount by code
//       final discount = await discountRepository.getDiscountByCode(event.code);

//       if (discount == null) {
//         emit(
//           currentState.copyWith(
//             status: DiscountStatus.error,
//             message: "Invalid coupon code",
//           ),
//         );
//         return;
//       }

//       /// 2. Validate coupon
//       final now = DateTime.now();

//       if (!discount.isActive) {
//         emit(
//           currentState.copyWith(
//             status: DiscountStatus.error,
//             message: "Coupon is inactive",
//           ),
//         );
//         return;
//       }

//       if (now.isAfter(discount.validUntil)) {
//         emit(
//           currentState.copyWith(
//             status: DiscountStatus.error,
//             message: "Coupon expired",
//           ),
//         );
//         return;
//       }

//       if (event.cartTotal < discount.minAmount) {
//         emit(
//           currentState.copyWith(
//             status: DiscountStatus.error,
//             message: "Minimum amount is ${discount.minAmount} MMK",
//           ),
//         );
//         return;
//       }

//       final hasUsedAnyCoupon = await discountRepository.hasUserUsedAnyCoupon(
//         event.userId,
//       );

//       final isFirstTimeUser = !hasUsedAnyCoupon;

//       if (discount.firstTimeOnly && !isFirstTimeUser) {
//         emit(
//           currentState.copyWith(
//             status: DiscountStatus.error,
//             message: "Only for first-time users",
//           ),
//         );
//         return;
//       }

//       final alreadyUsed = await discountRepository.hasUserUsedCoupon(
//         userId: event.userId,
//         code: event.code,
//       );

//       if (alreadyUsed) {
//         emit(
//           currentState.copyWith(
//             status: DiscountStatus.error,
//             message: "You already used this coupon",
//           ),
//         );
//         return;
//       }

//       final discountAmount = (event.cartTotal * discount.percentage) / 100;

//       final newTotal = event.cartTotal - discountAmount;

//       print('newTotal is $newTotal');

//       /// 5. Save usage
//       // await discountRepository.saveCouponUsage(
//       //   userId: event.userId,
//       //   code: event.code,
//       // );

//       // final cartRepo = CartRepository();

//       // cartRepo.saveCoupon(
//       //   AppliedCouponModel(code: discount.code, discountAmount: discountAmount),
//       // );

//       emit(
//         currentState.copyWith(
//           status: DiscountStatus.success,
//           message: "Coupon applied",
//           discountAmount: discountAmount,
//           newTotal: newTotal,
//           appliedDiscount: discount,
//         ),
//       );
//     } catch (e) {
//       if (state is DiscountLoaded) {
//         emit(
//           (state as DiscountLoaded).copyWith(
//             status: DiscountStatus.error,
//             message: e.toString(),
//           ),
//         );
//       }
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/order/order_detail_screen.dart';

// class OrderCard extends StatelessWidget {
//   final String title, date, name, price, status;
//   final Color color;

//   const OrderCard({
//     super.key,
//     required this.title,
//     required this.date,
//     required this.name,
//     required this.price,
//     required this.status,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return OrderDetailScreen();
//             },
//           ),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             /// Top
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("ID: 65JHG1"),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: color,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: Text(
//                     status,
//                     style: const TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ),
//               ],
//             ),

//             const Divider(),

//             /// Middle
//             Row(
//               children: [
//                 Container(width: 50, height: 50, color: Colors.grey.shade300),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(date),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const Divider(),

//             /// Bottom
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(name),
//                 Text(
//                   price,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// =================//

// import 'package:flutter/material.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/order/widgets/order_card.dart';
// import 'package:plantify_plantshop_project/utils/constants/colors.dart';

// class MyOrdersScreen extends StatelessWidget {
//   const MyOrdersScreen({super.key});

//   Widget _tab(String text, bool active) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       decoration: BoxDecoration(
//         color: active ? Colors.green : Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppColor.primary),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: active ? Colors.white : Colors.black54),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Orders"), centerTitle: true),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const SizedBox(height: 15),

//             SizedBox(
//               height: 35,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext context, int index) {
//                   return _tab("All", false);
//                 },
//                 separatorBuilder: (BuildContext context, int index) {
//                   return SizedBox(width: 10);
//                 },
//                 itemCount: 5,
//               ),
//             ),
//             const SizedBox(height: 15),

//             Expanded(
//               child: ListView(
//                 children: [
//                   OrderCard(
//                     title: "Snake Plant",
//                     date: "6 Jan, 2025",
//                     name: "Sarah",
//                     price: "\$32.43",
//                     status: "Pending",
//                     color: Colors.blueGrey,
//                   ),
//                   OrderCard(
//                     title: "Jad Plant",
//                     date: "6 Feb, 2025",
//                     name: "Janna",
//                     price: "\$66.73",
//                     status: "Shipping",
//                     color: Colors.orange,
//                   ),
//                   OrderCard(
//                     title: "Snake Plant",
//                     date: "6 Jan, 2025",
//                     name: "Sarah",
//                     price: "\$32.43",
//                     status: "Processing",
//                     color: Colors.cyan,
//                   ),
//                   OrderCard(
//                     title: "Snake Plant",
//                     date: "6 Jan, 2025",
//                     name: "Sarah",
//                     price: "\$32.43",
//                     status: "Delivered",
//                     color: Colors.green,
//                   ),
//                   OrderCard(
//                     title: "Snake Plant",
//                     date: "6 Jan, 2025",
//                     name: "Sarah",
//                     price: "\$32.43",
//                     status: "Canceled",
//                     color: Colors.red,
//                   ),
//                 ],
//               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/order/bloc/order_bloc.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/order/widgets/order_detail_row.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/order/widgets/order_detail_timeline.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/product_detail_image_slider.dart';

// class OrderDetailScreen extends StatefulWidget {
//   final String orderId;
//   const OrderDetailScreen({super.key, required this.orderId});

//   @override
//   State<OrderDetailScreen> createState() => _OrderDetailScreenState();
// }

// class _OrderDetailScreenState extends State<OrderDetailScreen> {
//   final PageController _controller = PageController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<OrderBloc>().add(FetchOrderDetail(widget.orderId));
//   }

//   static Widget section({required String title, required Widget child}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           child,
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Detail"),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//       ),
//       body: BlocBuilder<OrderBloc, OrderState>(
//         builder: (context, state) {
//           if (state is OrderLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is OrderError) {
//             return Center(child: Text(state.message));
//           }

//           if (state is OrderDetailLoaded) {
//             final order = state.order;

//             /// 🪴 collect plants
//             final plants = order.items!
//                 .map((e) => e.plant)
//                 .where((p) => p != null)
//                 .toList();

//             /// 🖼 multiple images
//             Widget imageSection;

//             if (plants.isNotEmpty) {
//               /// 👉 Use first plant for slider (with multiple images)
//               imageSection = ProductDetailImageSlider(
//                 controller: _controller,
//                 plantData: plants.first!,
//                 isNetworkImage: true,
//               );
//             } else {
//               imageSection = Container(
//                 height: 220,
//                 color: Colors.grey.shade300,
//               );
//             }

//             String title = "Order";
//             if (order.items!.isNotEmpty) {
//               final first = order.items!.first.plant?.name ?? "Plant";

//               if (order.items!.length > 1) {
//                 title = "$first +${order.items!.length - 1} more";
//               } else {
//                 title = first;
//               }
//             }

//             /// 💰 price calc
//             final subtotal = order.items!.fold(
//               0.0,
//               (sum, item) => sum + item.subtotal,
//             );

//             const deliveryFee = 1000.0;
//             final total = order.totalAmount;

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   imageSection,

//                   const SizedBox(height: 20),

//                   /// 📄 Product Info
//                   section(
//                     title: "Product Info",
//                     child: Column(
//                       children: [
//                         OrderDetailRow(left: "Product", right: title),
//                         OrderDetailRow(
//                           left: "Order Date",
//                           right:
//                               "${order.createdAt!.day}-${order.createdAt!.month}-${order.createdAt!.year}",
//                         ),
//                         OrderDetailRow(
//                           left: "Order ID",
//                           right: order.id!.substring(0, 6),
//                         ),
//                         OrderDetailRow(left: "Status", right: order.status!),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 15),

//                   /// 📍 Address (mock for now)
//                   section(
//                     title: "Delivery Address",
//                     child: const Text("User address here"),
//                   ),

//                   const SizedBox(height: 15),

//                   /// 💰 Price
//                   section(
//                     title: "Order Price",
//                     child: Column(
//                       children: [
//                         OrderDetailRow(
//                           left: "Subtotal",
//                           right: "\$${subtotal.toStringAsFixed(2)}",
//                         ),
//                         const OrderDetailRow(
//                           left: "Delivery Fee",
//                           right: "\$1000",
//                         ),
//                         const Divider(),
//                         OrderDetailRow(
//                           left: "Total",
//                           right: "\$${total.toStringAsFixed(2)}",
//                           bold: true,
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       minimumSize: const Size(double.infinity, 50),
//                     ),
//                     child: const Text("Mark as delivered"),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return const SizedBox();
//           // return SingleChildScrollView(
//           //   padding: const EdgeInsets.all(16),
//           //   child: Column(
//           //     children: [
//           //       Container(
//           //         height: 220,
//           //         width: double.infinity,
//           //         decoration: BoxDecoration(
//           //           color: Colors.grey.shade300,
//           //           borderRadius: BorderRadius.circular(16),
//           //         ),
//           //       ),

//           //       const SizedBox(height: 20),

//           //       /// 📄 Product Info
//           //       section(
//           //         title: "Product Info",
//           //         child: Column(
//           //           children: const [
//           //             OrderDetailRow(left: "Product Name", right: "Jade Plant"),
//           //             OrderDetailRow(left: "Order Date", right: "Jan 7, 2024"),
//           //             OrderDetailRow(left: "Product ID", right: "65SKG1"),
//           //             OrderDetailRow(
//           //               left: "Product Status",
//           //               right: "Processing",
//           //             ),
//           //           ],
//           //         ),
//           //       ),

//           //       const SizedBox(height: 15),

//           //       section(
//           //         title: "Delivery Address",
//           //         child: const Text(
//           //           "No 219, 8 ward, Shwe Pyi Thar Township, Yangon City",
//           //         ),
//           //       ),

//           //       const SizedBox(height: 15),

//           //       /// 💰 Price
//           //       section(
//           //         title: "Order Price",
//           //         child: Column(
//           //           children: const [
//           //             OrderDetailRow(left: "Price", right: "\$30.43"),
//           //             OrderDetailRow(left: "Discount", right: "\$1.00"),
//           //             OrderDetailRow(left: "Delivery Fee", right: "\$1.00"),
//           //             Divider(),
//           //             OrderDetailRow(
//           //               left: "Total",
//           //               right: "\$32.43",
//           //               bold: true,
//           //             ),
//           //           ],
//           //         ),
//           //       ),

//           //       const SizedBox(height: 15),

//           //       /// 🚚 Tracking (will remove)
//           //       // _section(
//           //       //   title: "Order Tracking",
//           //       //   child: Column(
//           //       //     crossAxisAlignment: CrossAxisAlignment.start,
//           //       //     children: [
//           //       //       OrderDetailTimeline(text: "Order Received", active: true),
//           //       //       OrderDetailTimeline(text: "Payment Confirmed", active: true),
//           //       //       OrderDetailTimeline(text: "Processing", active: true),
//           //       //       OrderDetailTimeline(text: "Shipping", active: false),
//           //       //     ],
//           //       //   ),
//           //       // ),
//           //       const SizedBox(height: 20),

//           //       SizedBox(
//           //         width: double.infinity,
//           //         child: ElevatedButton(
//           //           onPressed: () {},
//           //           style: ElevatedButton.styleFrom(
//           //             padding: const EdgeInsets.symmetric(vertical: 16),
//           //             backgroundColor: Colors.green,
//           //           ),
//           //           child: const Text("Marked as delivered"),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // );
//         },
//       ),
//     );
//   }
// }
