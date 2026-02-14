import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _buildDialogContainer(context),
    );
  }

  Widget _buildDialogContainer(BuildContext context) {
    return Center(child: _buildConstrainedContainer(context));
  }

  Widget _buildConstrainedContainer(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 320,
        minWidth: 251.5,
      ),
      child: _buildIntrinsicWidthContainer(context),
    );
  }

  Widget _buildIntrinsicWidthContainer(BuildContext context) {
    return IntrinsicWidth(child: _buildDecoratedContainer(context));
  }

  Widget _buildDecoratedContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: _buildDialogBody(context),
    );
  }

  Widget _buildDialogBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeaderRow(context),
        _buildTitleSection(),
        _buildPhoneButtonWithSpacing(),
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_buildCloseButton(context)],
    );
  }

  Widget _buildTitleSection() {
    return Transform.translate(
      offset: const Offset(0, -5),
      child: _buildTitle(),
    );
  }

  Widget _buildPhoneButtonWithSpacing() {
    return Column(
      children: [
        const SizedBox(height: 23),
        _buildPhoneButton(),
        const SizedBox(height: 19),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: SvgPicture.asset(
        AppIcons.popUpCloseButtonIcon,
        width: AppDimensions.iconSmall,
        height: AppDimensions.iconSmall,
        colorFilter: const ColorFilter.mode(
          AppColors.textOnDark,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppStrings.needHelpText,
      style: AppTextStyles.h2.copyWith(color: AppColors.textOnDark),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPhoneButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: AppDimensions.small,
        ),
        decoration: BoxDecoration(
          color: AppColors.accent,
        borderRadius: BorderRadius.circular(
          13,
        ),
        ),
        child: _buildPhoneButtonContent(),
      ),
    );
  }

  Widget _buildPhoneButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPhoneIcon(),
        const SizedBox(width: AppDimensions.small),
        _buildPhoneNumber(),
      ],
    );
  }

  Widget _buildPhoneIcon() {
    return SvgPicture.asset(
      AppIcons.phoneIcon,
      width: AppDimensions.iconSmall,
      height: AppDimensions.iconSmall,
      colorFilter: const ColorFilter.mode(
        AppColors.textOnDark,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Text(
      AppStrings.phoneNumber,
      style: AppTextStyles.buttonText.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
