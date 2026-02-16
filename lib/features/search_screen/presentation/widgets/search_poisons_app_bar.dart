import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class SearchAppBar extends StatefulWidget {
  final Function(String) onTextChanged;
  final Function(String) onSearchSubmitted;
  final VoidCallback onClearPressed;
  final VoidCallback? onHelpPressed;
  final TextEditingController? controller;
  final bool autofocus;

  const SearchAppBar({
    super.key,
    required this.onTextChanged,
    required this.onSearchSubmitted,
    required this.onClearPressed,
    this.onHelpPressed,
    this.controller,
    this.autofocus = true,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      child: Container(
        color: AppColors.background,
        padding: const EdgeInsets.only(
          right: AppDimensions.medium,
          top: AppDimensions.medium,
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      children: [
        _buildBackButton(),
        Expanded(child: _buildSearchBar()),
        if (widget.onHelpPressed != null) ...[
          const SizedBox(width: AppDimensions.small),
          _buildHelpButton(),
        ],
      ],
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: SvgPicture.asset(
        AppIcons.arrowBackIcon,
        width: AppDimensions.iconSmall,
        height: AppDimensions.iconSmall,
      ),
      onPressed: _onBackPressed,
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: AppDimensions.searchBarHeight,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSearchBar),
      ),
      child: _buildSearchBarContent(),
    );
  }

  Widget _buildSearchBarContent() {
    return Row(
      children: [
        const SizedBox(width: AppDimensions.medium),
        _buildSearchField(),
        _buildClearButton(),
        const SizedBox(width: AppDimensions.small),
      ],
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        style: AppTextStyles.mediumBody,
        decoration: _buildSearchFieldDecoration(),
        onChanged: widget.onTextChanged,
        onSubmitted: widget.onSearchSubmitted,
      ),
    );
  }

  InputDecoration _buildSearchFieldDecoration() {
    return const InputDecoration(
      hintText: AppStrings.searchHintText,
      hintStyle: AppTextStyles.regularText,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(vertical: 12),
      filled: false,
    );
  }

  Widget _buildClearButton() {
    return IconButton(
      icon: SvgPicture.asset(
        AppIcons.cancelIcon,
        width: AppDimensions.iconSmall,
        height: AppDimensions.iconSmall,
      ),
      onPressed: _onClearPressed,
    );
  }

  Widget _buildHelpButton() {
    return GestureDetector(
      onTap: widget.onHelpPressed,
      child: Container(
        width: AppDimensions.searchBarHeight,
        height: AppDimensions.searchBarHeight,
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            AppIcons.searchBarButtonPhoneIcon,
            width: AppDimensions.iconSmall,
            height: AppDimensions.iconSmall,
            colorFilter: const ColorFilter.mode(
              AppColors.textOnDark,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  void _onClearPressed() {
    _controller.clear();
    widget.onClearPressed();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
