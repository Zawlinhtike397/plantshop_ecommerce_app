import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;
  final Widget? trailingWidget;
  const ProfileTile({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 12.0,
              children: [
                if (icon != null) Icon(icon),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            if (trailingWidget != null) trailingWidget!,
          ],
        ),
      ),
    );
  }
}
