import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_layout.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../core/widgets/risk_badge.dart';
import '../../../search_screen/domain/entities/poison_data.dart';

class AllPoisonsCardItem extends StatelessWidget {
  final PoisonData poison;
  final ScreenLayout screenLayout;
  final VoidCallback onTap;
  final String? searchQuery;

  const AllPoisonsCardItem({
    super.key,
    required this.poison,
    required this.screenLayout,
    required this.onTap,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: screenLayout.getAllPoisonCardHeight(),
        margin: _buildCardMargin(),
        decoration: _buildCardDecoration(),
        child: _buildCardContent(),
      ),
    );
  }

  EdgeInsets _buildCardMargin() {
    return const EdgeInsets.symmetric(
      horizontal: AppDimensions.medium,
      vertical: AppDimensions.small,
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Column _buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),
        const SizedBox(height: 12),
        _buildBadgeAndTitle(),
      ],
    );
  }

  Widget _buildImage() {
    return SizedBox(
      width: double.infinity,
      height: screenLayout.getAllPoisonCardImageHeight(),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: _buildImageContent(),
      ),
    );
  }

  Widget _buildImageContent() {
    if (poison.imageUrl.isNotEmpty) {
      return Image.network(
        poison.imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildEmptyPlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return UiUtils.buildLoadingIndicator();
        },
      );
    }
    return _buildEmptyPlaceholder();
  }

  Widget _buildEmptyPlaceholder() {
    return Container(
      color: AppColors.emptyPlaceholderIcon,
      width: double.infinity,
      child: Center(child: SvgPicture.asset(AppIcons.emptyPlaceholderIcon)),
    );
  }

  Widget _buildBadgeAndTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.small,
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RiskBadge(riskLevel: poison.riskLevel),
          const SizedBox(height: 8),
          _buildPoisonName(),
          const SizedBox(height: 4),
          _buildAliases(),
        ],
      ),
    );
  }

  Text _buildPoisonName() {
    return Text(
      poison.name,
      style: AppTextStyles.h4Bold,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAliases() {
    final displayAliases = poison.aliases.map((alias) => alias.termName);

    return Text(
      'Also known as: $displayAliases',
      style: const TextStyle(color: AppColors.textKeyboard, fontSize: 10),
      overflow: TextOverflow.ellipsis,
    );
  }
}
