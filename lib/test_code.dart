//home_screen backup
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:plantify_plantshop_project/common/plant_info/bloc/plant_bloc.dart';
// import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
// import 'package:plantify_plantshop_project/common/widgets/product/custom_filter_chip.dart';
// import 'package:plantify_plantshop_project/common/widgets/product/heading_widget.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/grid_view_widget.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/plant_card.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/top_header_widget.dart';
// import 'package:plantify_plantshop_project/utils/constants/colors.dart';
// import 'package:plantify_plantshop_project/utils/popups/category_chip_shimmer.dart';
// import 'package:plantify_plantshop_project/utils/popups/plant_card_shimmer.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String selectedCategory = 'All';

//   @override
//   void initState() {
//     super.initState();
//     context.read<PlantBloc>().add(LoadPlantsEvent());
//   }

//   Widget buildPlantGrid({
//     required PlantState state,
//     List<PlantModel>? filteredPlants,
//   }) {
//     if (state is PlantLoading) {
//       return GridViewWidget(
//         itemCount: 6,
//         crossAxisCount: 2,
//         itemBuilder: (_, __) => const PlantCardShimmer(),
//       );
//     }

//     if (filteredPlants == null || filteredPlants.isEmpty) {
//       return const Center(
//         child: Padding(
//           padding: EdgeInsets.only(top: 80),
//           child: Text('No plant data found'),
//         ),
//       );
//     }

//     return GridViewWidget(
//       itemCount: filteredPlants.length,
//       crossAxisCount: 2,
//       itemBuilder: (context, index) => PlantCard(plant: filteredPlants[index]),
//     );
//   }

//   Widget buildCategoryChips({required PlantState state}) {
//     if (state is PlantLoading) {
//       return SizedBox(
//         height: 40,
//         child: ListView.separated(
//           scrollDirection: Axis.horizontal,
//           itemCount: 5,
//           separatorBuilder: (_, __) => const SizedBox(width: 10),
//           itemBuilder: (_, __) => const CategoryChipShimmer(),
//         ),
//       );
//     }

//     final plants = (state is PlantLoaded) ? state.plants : <PlantModel>[];
//     final categories = ['All', ...plants.map((p) => p.category).toSet()];

//     return SizedBox(
//       height: 40,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 10),
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedCategory = category;
//               });
//             },
//             child: CustomFilterChip(
//               label: category,
//               isSelected: selectedCategory == category,
//               showColor: true,
//               showBorder: true,
//               borderColor: AppColor.primary.withValues(alpha: 0.5),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         body: BlocBuilder<PlantBloc, PlantState>(
//           builder: (context, state) {
//             // if (state is PlantLoading) {
//             //   return const Center(child: CircularProgressIndicator());
//             // } else
//             if (state is PlantLoaded) {
//               final plants = state.plants;
//               final categories = [
//                 'All',
//                 ...plants.map((plant) => plant.category).toSet(),
//               ];

//               final filteredPlants = selectedCategory == 'All'
//                   ? plants
//                   : plants
//                         .where((p) => p.category == selectedCategory)
//                         .toList();

//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     TopHeaderWidget(),

//                     Padding(
//                       padding: EdgeInsets.all(20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (categories.length > 1) ...[
//                             HeadingWidget(name: 'Categories'),
//                             SizedBox(height: 15.0),
//                             SizedBox(
//                               height: 40,
//                               child: ListView.separated(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: categories.length,
//                                 separatorBuilder: (_, __) =>
//                                     const SizedBox(width: 10),
//                                 itemBuilder: (context, index) {
//                                   final category = categories[index];

//                                   return GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         selectedCategory = category;
//                                       });
//                                     },
//                                     child: CustomFilterChip(
//                                       label: category,
//                                       isSelected: selectedCategory == category,
//                                       showColor: true,
//                                       showBorder: true,
//                                       borderColor: AppColor.primary.withValues(
//                                         alpha: 0.5,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             SizedBox(height: 20.0),
//                           ],
//                           if (filteredPlants.isEmpty)
//                             const Center(
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: 80),
//                                 child: Text('No plant data found'),
//                               ),
//                             )
//                           else
//                             GridViewWidget(
//                               itemCount: filteredPlants.length,
//                               crossAxisCount: 2,
//                               itemBuilder: (context, index) {
//                                 return PlantCard(plant: filteredPlants[index]);
//                               },
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is PlantError) {
//               return Center(child: Text(state.message));
//             }
//             return Center(
//               child: const SizedBox(child: Text('Yolo home screen')),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// ================================

// import 'package:flutter/material.dart';

// class GridViewWidget extends StatelessWidget {
//   final int? itemCount;
//   final int crossAxisCount;
//   final Widget? Function(BuildContext, int) itemBuilder;

//   const GridViewWidget({
//     super.key,
//     this.itemCount,
//     required this.crossAxisCount,
//     required this.itemBuilder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: itemCount,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 10,
//         childAspectRatio: 0.56,
//       ),
//       itemBuilder: itemBuilder,
//     );
//   }
// }

//=================================================

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:plantify_plantshop_project/common/search/cubit/search_cubit.dart';
// import 'package:plantify_plantshop_project/common/widgets/container/search_container.dart';
// import 'package:plantify_plantshop_project/common/widgets/product/custom_filter_chip.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/app_filter_button.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/grid_view_widget.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/plant_card.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/search_products/widgets/filter_sheet.dart';
// import 'package:plantify_plantshop_project/plant_data.dart';
// import 'package:plantify_plantshop_project/utils/constants/colors.dart';

// class SearchResultScreen extends StatefulWidget {
//   const SearchResultScreen({super.key});

//   @override
//   State<SearchResultScreen> createState() => _SearchResultScreenState();
// }

// class _SearchResultScreenState extends State<SearchResultScreen> {
//   void _openFilterSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       isDismissible: false,

//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//       ),
//       backgroundColor: Theme.of(context).brightness == Brightness.dark
//           ? AppColor.darkerGrey
//           : Theme.of(context).scaffoldBackgroundColor,
//       builder: (context) {
//         return const FilterSheet();
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     // context.read<SearchCubit>().clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final exampleFilters = [
//       //   'Price (High/Low)',
//       // 'Sale (High/Low )',
//       'Name',
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//         title: SearchContainer(
//           searchBarText: 'Search plants',
//           icon: Iconsax.search_normal,
//           openSearchPageOnTap: false,
//           // showBorder: true,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
//           child: Column(
//             spacing: 16.0,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 40,
//                 child: Row(
//                   spacing: 10.0,
//                   children: [
//                     AppFilterButton(
//                       iconColorFilter: ColorFilter.mode(
//                         AppColor.buttonPrimary,
//                         BlendMode.srcIn,
//                       ),
//                       backgroundColor: Colors.transparent,
//                       onTap: () {
//                         _openFilterSheet(context);
//                       },
//                       showBorder: true,
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: exampleFilters.length,

//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(right: 10.0),
//                             child: CustomFilterChip(
//                               label: exampleFilters[index],
//                               showColor: false,
//                               showBorder: true,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               BlocBuilder<SearchCubit, String>(
//                 builder: (context, query) {
//                   final filteredPlants = query.isEmpty
//                       ? plants
//                       : plants.where((plant) {
//                           final name = plant['name'].toString().toLowerCase();
//                           return name.contains(query.toLowerCase().trim());
//                         }).toList();

//                   if (filteredPlants.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         'No plants found 🌱',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     );
//                   }

//                   // return GridViewWidget(
//                   //   itemCount: filteredPlants.length,
//                   //   crossAxisCount: 2,
//                   //   itemBuilder: (context, index) {
//                   //     return PlantCard(plant: filteredPlants[index]);
//                   //   },
//                   // );
//                   return SizedBox();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ========================

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:plantify_plantshop_project/common/plant_info/bloc/plant_bloc.dart';
// import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
// import 'package:plantify_plantshop_project/common/widgets/loaders/animation_loader.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/favourite/bloc/favourites_bloc.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/grid_view_widget.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/home/widgets/plant_card.dart';
// import 'package:plantify_plantshop_project/features/plant_shop/navigation/navigation_cubit.dart';
// import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

// class FavouriteScreen extends StatefulWidget {
//   const FavouriteScreen({super.key});

//   @override
//   State<FavouriteScreen> createState() => _FavouriteScreenState();
// }

// class _FavouriteScreenState extends State<FavouriteScreen> {
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<FavouritesBloc>().add(LoadFavouritesEvent());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Favourites',
//           style: Theme.of(context).textTheme.titleLarge!.copyWith(
//             fontSize: 17,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//       ),

//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: BlocBuilder<PlantBloc, PlantState>(
//             builder: (context, plantState) {
//               if (plantState is PlantLoaded) {
//                 return BlocBuilder<FavouritesBloc, FavouritesState>(
//                   builder: (context, favState) {
//                     List<PlantModel> favouritePlants = [];

//                     if (favState is FavouriteLoaded) {
//                       favouritePlants = plantState.plants
//                           .where((p) => favState.favouriteIds.contains(p.id))
//                           .toList();
//                     }

//                     if (favState is FavouriteLoading ||
//                         plantState is PlantLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     if (favouritePlants.isEmpty) {
//                       return Center(
//                         child: AnimationLoader(
//                           headingText: 'Wishlist is empty!',
//                           animation: ImageStrings.emptyAnimation,
//                           smallText: 'Add something that you wish to buy here',
//                           showActionButton: true,
//                           actionText: 'Add Products',
//                           onPressed: () {
//                             context.read<NavigationCubit>().changeIndex(0);
//                           },
//                         ),
//                       );
//                     }

//                     return GridViewWidget(
//                       itemCount: favouritePlants.length,
//                       crossAxisCount: 2,
//                       itemBuilder: (context, index) {
//                         final plant = favouritePlants[index];
//                         return PlantCard(plant: plant);
//                       },
//                     );
//                   },
//                 );
//               }

//               return const SizedBox();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
