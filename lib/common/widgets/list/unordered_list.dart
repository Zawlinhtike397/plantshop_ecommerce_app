import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/list/unordered_list_item.dart';

class UnorderedList extends StatelessWidget {
  final List<String> texts;
  const UnorderedList({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      widgetList.add(UnorderedListItem(text: text));
      widgetList.add(SizedBox(height: 5.0));
    }

    return Column(spacing: 5.0, children: widgetList);
  }
}
