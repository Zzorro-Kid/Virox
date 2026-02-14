import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.primary,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.1875,
    color: AppColors.textSecondary,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle h4Bold = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const TextStyle regularText = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.textSecondary,
  );

  static const TextStyle mediumBody = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.31,
    color: AppColors.textPrimary,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.214,
    color: AppColors.textOnDark,
  );

  static const TextStyle firstAidCardTitle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 17 / 14,
    color: AppColors.textOnDark,
  );

  static const TextStyle labelBig = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.214,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.167,
    letterSpacing: -0.01,
    color: AppColors.textOnDark,
  );

  static const TextStyle keyboardDefault = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 1.27,
    color: AppColors.textPrimary,
  );

  static const TextStyle keyboardLarge = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 19,
    fontWeight: FontWeight.w400,
    height: 1.26,
    color: AppColors.textPrimary,
  );

  static const TextStyle suggestionText = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 1.18,
    color: AppColors.textKeyboard,
  );

  static const TextStyle badgeText = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 14 / 12,
  );

  static const TextStyle serviceTitle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.iconPrimary,
  );

  AppTextStyles._();
}
