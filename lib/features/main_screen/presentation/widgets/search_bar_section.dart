import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.medium,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppDimensions.medium),
        _buildTitle(),
        const SizedBox(height: 12),
        _buildSearchField(context),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      AppStrings.searchBarTitle,
      style: AppTextStyles.h2,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return GestureDetector(
      onTap: () => _openSearchScreen(context),
      child: _buildSearchFieldContainer(),
    );
  }

  void _openSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.searchPage);
  }

  Widget _buildSearchFieldContainer() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.iconPrimary, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: _buildSearchFieldContent(),
    );
  }

  Widget _buildSearchFieldContent() {
    return Row(children: [_buildSearchIcon(), _buildPlaceholder()]);
  }

  Widget _buildSearchIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.medium,
        vertical: 12,
      ),
      child: SvgPicture.asset(AppIcons.searchIcon),
    );
  }

  Widget _buildPlaceholder() {
    return Text(
      AppStrings.searchHintText,
      style: AppTextStyles.regularText.copyWith(color: AppColors.textSecondary),
    );
  }
}
