import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_layout.dart';
import '../../domain/entities/first_aid_type_data.dart';

class FirstAidCard extends StatelessWidget {
  final FirstAidTypeData category;
  final String title;
  final VoidCallback onTap;
  final ScreenLayout screenLayout;

  const FirstAidCard({
    super.key,
    required this.category,
    required this.title,
    required this.onTap,
    required this.screenLayout,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenLayout.getFirstAidCardHeight(),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            SvgPicture.asset(category.iconPath),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyles.firstAidCardTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
