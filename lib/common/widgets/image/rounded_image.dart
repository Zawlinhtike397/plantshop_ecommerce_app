import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/popups/shimmer_effect.dart';

class AppRoundedImage extends StatelessWidget {
  final double? width, height;
  final String imageUrl;
  final bool isApplyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final void Function()? onTap;
  final double borderRadius;

  const AppRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.isApplyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.onTap,
    this.borderRadius = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: isApplyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
        ),
        child: ClipRRect(
          borderRadius: isApplyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Center(
            child: isNetworkImage
                ? CachedNetworkImage(
                    key: ValueKey(imageUrl),
                    imageUrl: imageUrl,
                    fit: fit,
                    placeholder: (context, url) =>
                        const ZShimmerEffect(width: 72, height: 72),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image(image: AssetImage(imageUrl), fit: fit),
          ),
        ),
      ),
    );
  }
}
