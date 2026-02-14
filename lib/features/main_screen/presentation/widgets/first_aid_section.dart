import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_layout.dart';
import '../../domain/constants/first_aid_content.dart';
import '../../domain/entities/first_aid_content_data.dart';
import 'first_aid_card.dart';

class FirstAidSection extends StatelessWidget {
  static const double _spacing = 4;
  final ScreenLayout screenLayout;

  const FirstAidSection({super.key, required this.screenLayout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.medium),
      decoration: BoxDecoration(
        color: AppColors.surfaceBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Text(
            AppStrings.firstAidPoisoning,
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          _buildLayout(firstAidContent),
        ],
      ),
    );
  }

  Widget _buildLayout(List<FirstAidContentData> items) {
    switch (screenLayout) {
      case ScreenLayout.portrait320:
        return _buildTwoColumns(items);
      case ScreenLayout.landscape320:
        return _buildFourColumns(items);
      case ScreenLayout.portrait375:
        return _buildFourColumns(items);
      case ScreenLayout.landscape375:
        return _buildFourColumns(items);
      case ScreenLayout.portrait320Zoomed:
        return _buildOneColumn(items);
      case ScreenLayout.landscape320Zoomed:
        return _buildTwoColumns(items);
      case ScreenLayout.portrait375Zoomed:
        return _buildTwoColumns(items);
      case ScreenLayout.landscape375Zoomed:
        return _buildFourColumns(items);
    }
  }

  Widget _buildOneColumn(List<FirstAidContentData> items) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: _spacing),
              child: SizedBox(
                width: double.infinity,
                child: _buildFirstAidCard(item),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildTwoColumns(List<FirstAidContentData> items) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFirstAidCard(items[0])),
            const SizedBox(width: _spacing),
            Expanded(child: _buildFirstAidCard(items[1])),
          ],
        ),
        const SizedBox(height: _spacing),
        Row(
          children: [
            Expanded(child: _buildFirstAidCard(items[2])),
            const SizedBox(width: _spacing),
            Expanded(child: _buildFirstAidCard(items[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildFourColumns(List<FirstAidContentData> items) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFirstAidCard(items[0])),
            const SizedBox(width: _spacing),
            Expanded(child: _buildFirstAidCard(items[1])),
            const SizedBox(width: _spacing),
            Expanded(child: _buildFirstAidCard(items[2])),
            const SizedBox(width: _spacing),
            Expanded(child: _buildFirstAidCard(items[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildFirstAidCard(FirstAidContentData item) {
    return FirstAidCard(
      category: item.category,
      title: item.title,
      onTap: () {},
      screenLayout: screenLayout,
    );
  }
}
