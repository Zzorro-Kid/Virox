import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_constants.dart';

class SocialMediaSection extends StatelessWidget {
  const SocialMediaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          iconPath: AppIcons.facebookIcon,
          onTap: () => _openSocialMedia(AppStrings.facebook),
        ),
        const SizedBox(width: AppDimensions.medium),
        _buildSocialButton(
          iconPath: AppIcons.instagramIcon,
          onTap: () => _openSocialMedia(AppStrings.instagram),
        ),
        const SizedBox(width: AppDimensions.medium),
        _buildSocialButton(
          iconPath: AppIcons.youtubeIcon,
          onTap: () => _openSocialMedia(AppStrings.youtube),
        ),
        const SizedBox(width: AppDimensions.medium),
        _buildSocialButton(
          iconPath: AppIcons.twitterIcon,
          onTap: () => _openSocialMedia(AppStrings.twitter),
        ),
        const SizedBox(width: AppDimensions.medium),
        _buildSocialButton(
          iconPath: AppIcons.tiktokIcon,
          onTap: () => _openSocialMedia(AppStrings.tiktok),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDimensions.socialButtonSize,
        height: AppDimensions.socialButtonSize,
        padding: const EdgeInsets.all(4),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }

  void _openSocialMedia(String platform) {}
}
