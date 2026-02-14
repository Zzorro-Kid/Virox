import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/risk_badge.dart';
import '../../domain/entities/poison_data.dart';
import '../../domain/entities/risk_level_data.dart';
import 'highlighted_text.dart';

class SearchResultsList extends StatelessWidget {
  final List<PoisonData> results;
  final String? searchQuery;

  const SearchResultsList({super.key, required this.results, this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: ListView.separated(
        padding: const EdgeInsets.all(AppDimensions.medium),
        itemCount: results.length,
        separatorBuilder: (context, index) => const Column(
          children: [
            SizedBox(height: 0),
            Divider(color: AppColors.border, thickness: 1, height: 0),
            SizedBox(height: 2.5),
          ],
        ),
        itemBuilder: (context, index) => _buildListItem(results[index]),
      ),
    );
  }

  Widget _buildListItem(PoisonData poison) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.small),
        child: _buildListItemContent(poison),
      ),
    );
  }

  Widget _buildListItemContent(PoisonData poison) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildPoisonInfo(poison)),
        const SizedBox(width: AppDimensions.medium),
        if (poison.riskLevel != RiskLevel.unknown)
          RiskBadge(riskLevel: poison.riskLevel),
      ],
    );
  }

  Widget _buildPoisonInfo(PoisonData poison) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPoisonName(poison.name),
        if (poison.aliases.isNotEmpty) _buildPoisonAlias(poison),
      ],
    );
  }

  Widget _buildPoisonName(String name) {
    return HighlightedText(
      text: name,
      query: searchQuery,
      style: AppTextStyles.regularText.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildPoisonAlias(PoisonData poison) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.small),
      child: HighlightedText(
        text: '(${_getMatchingAlias(poison, searchQuery)})',
        query: searchQuery,
        style: AppTextStyles.regularText.copyWith(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  String _getMatchingAlias(PoisonData poison, String? query) {
    if (query == null || query.isEmpty || poison.aliases.isEmpty) {
      return poison.aliases.first.termName;
    }

    final queryLower = query.toLowerCase();

    for (final alias in poison.aliases) {
      if (alias.termName.toLowerCase().contains(queryLower)) {
        return alias.termName;
      }
    }

    return poison.aliases.first.termName;
  }
}
