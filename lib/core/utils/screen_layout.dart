import 'package:flutter/material.dart';

class ScreenLayoutHelper {
  static ScreenLayout getScreenLayout(BuildContext context) {
    final orientation = MediaQuery.orientationOf(context);
    final sizeOf = MediaQuery.sizeOf(context);
    final screenWidth = sizeOf.width;
    final screenHeight = sizeOf.height;
    final textScaler = MediaQuery.textScalerOf(context);
    final isZoomed = textScaler.scale(1) >= 2.0;

    switch (orientation) {
      case Orientation.portrait:
        if (isZoomed) {
          if (screenWidth < 375) {
            return ScreenLayout.portrait320Zoomed;
          } else {
            return ScreenLayout.portrait375Zoomed;
          }
        } else {
          if (screenWidth < 375) {
            return ScreenLayout.portrait320;
          } else {
            return ScreenLayout.portrait375;
          }
        }
      case Orientation.landscape:
        if (isZoomed) {
          if (screenHeight < 375) {
            return ScreenLayout.landscape320Zoomed;
          } else {
            return ScreenLayout.landscape375Zoomed;
          }
        } else {
          if (screenHeight < 375) {
            return ScreenLayout.landscape320;
          } else {
            return ScreenLayout.landscape375;
          }
        }
    }
  }
}

enum ScreenLayout {
  portrait320,
  landscape320,
  portrait375,
  landscape375,
  portrait320Zoomed,
  landscape320Zoomed,
  portrait375Zoomed,
  landscape375Zoomed;

  double getFirstAidCardHeight() {
    const double firstAidCardHeightNormal = 97;
    const double firstAidCardHeightZoomed = 113;

    switch (this) {
      case ScreenLayout.portrait320:
      case ScreenLayout.landscape320:
      case ScreenLayout.portrait375:
      case ScreenLayout.landscape375:
        return firstAidCardHeightNormal;
      case ScreenLayout.portrait320Zoomed:
      case ScreenLayout.landscape320Zoomed:
      case ScreenLayout.portrait375Zoomed:
      case ScreenLayout.landscape375Zoomed:
        return firstAidCardHeightZoomed;
    }
  }

  double getPoisonCardHeight() {
    const double poisonCardHeightNormal = 188;
    const double poisonCardHeightZoomed = 231;

    switch (this) {
      case ScreenLayout.portrait320:
      case ScreenLayout.landscape320:
      case ScreenLayout.portrait375:
      case ScreenLayout.landscape375:
        return poisonCardHeightNormal;
      case ScreenLayout.portrait320Zoomed:
      case ScreenLayout.landscape320Zoomed:
      case ScreenLayout.portrait375Zoomed:
      case ScreenLayout.landscape375Zoomed:
        return poisonCardHeightZoomed;
    }
  }

  double getPoisonCardWidth() {
    const double poisonCardWidthNormal = 140;
    const double poisonCardWidthZoomed = 194;

    switch (this) {
      case ScreenLayout.portrait320:
      case ScreenLayout.landscape320:
      case ScreenLayout.portrait375:
      case ScreenLayout.landscape375:
        return poisonCardWidthNormal;
      case ScreenLayout.portrait320Zoomed:
      case ScreenLayout.landscape320Zoomed:
      case ScreenLayout.portrait375Zoomed:
      case ScreenLayout.landscape375Zoomed:
        return poisonCardWidthZoomed;
    }
  }

  double getTopHelpBarHeight() {
    const double topHelpBarHeightNormal = 76;
    const double topHelpBarHeightZoomed = 141;
    const double topHelpBarHeightZoomedLandscape = 81;

    switch (this) {
      case ScreenLayout.portrait320:
      case ScreenLayout.landscape320:
      case ScreenLayout.portrait375:
      case ScreenLayout.landscape375:
        return topHelpBarHeightNormal;
      case ScreenLayout.portrait320Zoomed:
      case ScreenLayout.portrait375Zoomed:
        return topHelpBarHeightZoomed;
      case ScreenLayout.landscape320Zoomed:
      case ScreenLayout.landscape375Zoomed:
        return topHelpBarHeightZoomedLandscape;
    }
  }

  bool isPortraitZoomed() {
    switch (this) {
      case ScreenLayout.portrait320Zoomed:
      case ScreenLayout.portrait375Zoomed:
        return true;
      default:
        return false;
    }
  }
}
