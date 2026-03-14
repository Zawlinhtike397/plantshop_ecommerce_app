import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ZProfileMenu extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;
  final IconData? icon;

  const ZProfileMenu({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
    this.icon = Iconsax.arrow_right_34,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: onTap != null
          ? const EdgeInsets.symmetric(vertical: 3)
          : const EdgeInsets.symmetric(vertical: 17),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onTap != null
              ? Expanded(
                  child: IconButton(
                    onPressed: onTap,
                    icon: Icon(icon, size: 12),
                  ),
                )
              : SizedBox(width: 25),
        ],
      ),
    );
  }
}
