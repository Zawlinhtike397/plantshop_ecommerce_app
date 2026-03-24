import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantify_plantshop_project/common/plant_info/bloc/plant_bloc.dart';
import 'package:plantify_plantshop_project/features/plant_shop/search_products/search_result_screen.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/debouncer/debouncer.dart';

class SearchContainer extends StatefulWidget {
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
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  late final Debouncer _debouncer;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (!widget.openSearchPageOnTap) {
      _debouncer.call(() {
        context.read<PlantBloc>().add(
          LoadPlantsEvent(category: 'All', searchQuery: value),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SearchBar(
      controller: _controller,
      hintText: widget.searchBarText,
      leading: widget.icon != null
          ? Icon(widget.icon, color: AppColor.midGray)
          : null,
      backgroundColor: WidgetStateProperty.all(
        widget.showColor
            ? isDarkMode
                  ? AppColor.darkerGrey
                  : AppColor.white
            : Colors.transparent,
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: widget.showBorder
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

      onTap: widget.openSearchPageOnTap
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const SearchResultScreen();
                  },
                ),
              );
            }
          : null,
      onChanged: widget.openSearchPageOnTap ? null : _onSearchChanged,
    );
  }
}
