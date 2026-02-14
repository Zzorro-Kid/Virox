import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/constants/more_service_data.dart';
import '../../domain/entities/more_service_item_data.dart';
import 'external_resources_section_dialog.dart';
import 'social_media_section.dart';

class MoreServicesSection extends StatelessWidget {
  const MoreServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.medium,
        right: AppDimensions.medium,
        bottom: AppDimensions.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.medium),
          const Text(AppStrings.externalResources, style: AppTextStyles.h2),
          const SizedBox(height: 12),
          _buildServicesList(context),
          const SizedBox(height: AppDimensions.large),
          const SocialMediaSection(),
        ],
      ),
    );
  }

  Widget _buildServicesList(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: moreServices.length,
          separatorBuilder: (context, index) => const Column(
            children: [
              Divider(color: AppColors.border, thickness: 1, height: 1),
              SizedBox(height: 11),
            ],
          ),
          itemBuilder: (context, index) {
            return _buildServiceTile(moreServices[index], context);
          },
        ),
        const Divider(color: AppColors.border, thickness: 1, height: 1),
      ],
    );
  }

  Widget _buildServiceTile(MoreServiceItemData service, BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
      child: GestureDetector(
        onTap: () => MoreServiceSectionDialog.show(context),
        child: Row(
          children: [
            _buildServiceIconWithSpacing(service.iconPath),
            _buildServiceTitleWithArrow(service.title),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceIconWithSpacing(String iconPath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(iconPath),
        const SizedBox(width: AppDimensions.small),
      ],
    );
  }

  Widget _buildServiceTitleWithArrow(String title) {
    return Expanded(
      child: Row(
        children: [
          Expanded(child: Text(title, style: AppTextStyles.serviceTitle)),
          SvgPicture.asset(AppIcons.arrowSquareOutIcon),
        ],
      ),
    );
  }
}
