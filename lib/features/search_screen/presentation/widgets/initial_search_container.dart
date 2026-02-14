import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class InitialSearchContainer extends StatelessWidget {
  const InitialSearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.only(
        left: AppDimensions.large,
        right: AppDimensions.large,
        top: AppDimensions.large,
      ),
      alignment: Alignment.topCenter,
      child: const Text(
        AppStrings.emptyStateDescription,
        style: AppTextStyles.regularText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
