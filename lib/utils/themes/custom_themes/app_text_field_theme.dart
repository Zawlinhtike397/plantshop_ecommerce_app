import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class AppTextFieldTheme {
  AppTextFieldTheme._();

  static InputDecorationTheme lightInputDecorTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    hintStyle: TextStyle().copyWith(color: AppColor.textSecondary),
    border: OutlineInputBorder().copyWith(
      borderSide: const BorderSide(color: AppColor.borderColor),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: AppColor.borderColor),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: AppColor.primary),
    ),
    errorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: AppColor.borderColor),
    ),
  );

  static InputDecorationTheme darkInputDecorTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    hintStyle: TextStyle().copyWith(
      fontWeight: FontWeight.w300,
      color: AppColor.textSecondary,
    ),
    border: OutlineInputBorder().copyWith(
      borderSide: const BorderSide(color: AppColor.borderColor),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: AppColor.borderColor),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: AppColor.primary),
    ),
    errorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: AppColor.borderColor),
    ),
  );
}
