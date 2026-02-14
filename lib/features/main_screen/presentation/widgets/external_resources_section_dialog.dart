import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class MoreServiceSectionDialog {
  static void show(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.dialogTitle),
        content: const Text(AppStrings.dialogDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.dialogCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.dialogConfirm),
          ),
        ],
      ),
    );
  }
}