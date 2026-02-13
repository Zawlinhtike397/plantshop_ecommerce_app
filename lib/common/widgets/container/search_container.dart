import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/search/cubit/search_cubit.dart';
import 'package:plantify_plantshop_project/features/plant_shop/search_products/search_result_screen.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class SearchContainer extends StatelessWidget {
  final IconData? icon;
  final String searchBarText;
  final bool showColor, showBorder;
  final bool openSearchPageOnTap;

  const SearchContainer({
    super.key,
    this.icon,
    required this.searchBarText,
    this.showColor = true,
    this.showBorder = false,
    this.openSearchPageOnTap = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SearchBar(
      hintText: searchBarText,
      leading: icon != null ? Icon(icon, color: AppColor.midGray) : null,
      backgroundColor: WidgetStateProperty.all(
        showColor
            ? isDarkMode
                  ? AppColor.darkerGrey
                  : AppColor.lightGray
            : Colors.transparent,
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: showBorder
              ? BorderSide(color: AppColor.borderColor)
              : BorderSide.none,
        ),
      ),
      elevation: WidgetStateProperty.all(0),

      textStyle: WidgetStateProperty.all(
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.gray),
      ),

      hintStyle: WidgetStateProperty.all(
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.gray),
      ),

      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12),
      ),

      onTap: openSearchPageOnTap
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchResultScreen()),
              );
            }
          : null,
      onChanged: openSearchPageOnTap
          ? null
          : (value) {
              context.read<SearchCubit>().updateQuery(value);
            },
    );
  }
}
