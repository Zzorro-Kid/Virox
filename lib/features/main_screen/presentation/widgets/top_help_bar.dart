import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_layout.dart';

class TopHelpBar extends StatelessWidget {
  final ScreenLayout screenLayout;

  const TopHelpBar({super.key, required this.screenLayout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenLayout.getTopHelpBarHeight(),
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.medium),
      child: screenLayout.isPortraitZoomed()
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 12),
                _buildPhoneButton(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildLogo(), _buildPhoneButton()],
            ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(AppIcons.mpcLogo);
  }

  Widget _buildPhoneButton() {
    return GestureDetector(
      onTap: _makePhoneCall,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: AppDimensions.small,
        ),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(13),
        ),
        child: _buildPhoneButtonContent(),
      ),
    );
  }

  void _makePhoneCall() {}

  Widget _buildPhoneButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPhoneIcon(),
        const SizedBox(width: AppDimensions.small),
        _buildPhoneText(),
      ],
    );
  }

  Widget _buildPhoneIcon() {
    return SvgPicture.asset(
      AppIcons.phoneIcon,
      colorFilter: const ColorFilter.mode(
        AppColors.textOnDark,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildPhoneText() {
    return Text(
      AppStrings.phoneNumber,
      style: AppTextStyles.buttonText.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
