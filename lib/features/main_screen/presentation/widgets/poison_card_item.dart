import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_layout.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../core/widgets/risk_badge.dart';
import '../../../search_screen/domain/entities/poison_data.dart';

class PoisonCardItem extends StatelessWidget {
  final PoisonData poison;
  final ScreenLayout screenLayout;

  const PoisonCardItem({
    super.key,
    required this.poison,
    required this.screenLayout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenLayout.getPoisonCardHeight(),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(height: 12),
          _buildBadgeAndTitle(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      width: screenLayout.getPoisonCardWidth(),
      height: 100,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        child: _buildImageContent(),
      ),
    );
  }

  Widget _buildImageContent() {
    if (poison.imageUrl.isNotEmpty) {
      return Image.network(
        poison.imageUrl,
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
      child: Center(child: SvgPicture.asset(AppIcons.emptyPlaceholderIcon)),
    );
  }

  Widget _buildBadgeAndTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RiskBadge(riskLevel: poison.riskLevel),
          const SizedBox(height: 4),
          Text(
            poison.name,
            style: AppTextStyles.h4Bold,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
