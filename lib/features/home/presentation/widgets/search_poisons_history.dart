import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class SearchPoisonsHistory extends StatelessWidget {
  final List<String> searchHistory;
  final Function(String) onHistoryItemTap;

  const SearchPoisonsHistory({
    super.key,
    required this.searchHistory,
    required this.onHistoryItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: ListView.separated(
        padding: const EdgeInsets.all(AppDimensions.medium),
        itemCount: searchHistory.length,
        separatorBuilder: (context, index) => const Column(
          children: [
            SizedBox(height: 0),
            Divider(color: AppColors.border, thickness: 1, height: 0),
            SizedBox(height: 2.5),
          ],
        ),
        itemBuilder: (context, index) {
          return _buildHistoryItem(searchHistory[index]);
        },
      ),
    );
  }

  Widget _buildHistoryItem(String query) {
    return InkWell(
      onTap: () => onHistoryItemTap(query),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.medium,
        ),
        child: _buildHistoryItemContent(query),
      ),
    );
  }

  Widget _buildHistoryItemContent(String query) {
    return Row(
      children: [
        const Icon(
          Icons.history,
          size: AppDimensions.iconSmall,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: AppDimensions.medium),
        Expanded(child: Text(query, style: AppTextStyles.mediumBody)),
      ],
    );
  }
}
