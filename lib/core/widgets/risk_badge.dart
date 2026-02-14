import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../features/home/domain/entities/risk_level_data.dart';

class RiskBadge extends StatelessWidget {
  final RiskLevel riskLevel;

  const RiskBadge({super.key, required this.riskLevel});

  @override
  Widget build(BuildContext context) {
    final badgeData = _getBadgeData(riskLevel);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: badgeData.backgroundColor,
        border: Border.all(color: badgeData.borderColor),
        borderRadius: BorderRadius.circular(27),
      ),
      child: _buildBadgeContent(badgeData),
    );
  }

  ({
    String label,
    Color backgroundColor,
    Color borderColor,
    Color textColor,
    String iconPath,
  })
  _getBadgeData(RiskLevel riskLevel) {
    switch (riskLevel) {
      case RiskLevel.highlyToxic:
        return _buildHighlyToxicData();
      case RiskLevel.mediumRisk:
        return _buildMediumRiskData();
      case RiskLevel.lowRisk:
        return _buildLowRiskData();
      case RiskLevel.unknown:
        return _buildUnknownData();
    }
  }

  ({
    String label,
    Color backgroundColor,
    Color borderColor,
    Color textColor,
    String iconPath,
  })
  _buildHighlyToxicData() {
    return (
      label: 'Highly Toxic',
      backgroundColor: const Color(0xFFFFD7D9),
      borderColor: const Color(0xFFBC2A34),
      textColor: const Color(0xFFB32B2B),
      iconPath: 'assets/icons/highly_toxic_face.svg',
    );
  }

  ({
    String label,
    Color backgroundColor,
    Color borderColor,
    Color textColor,
    String iconPath,
  })
  _buildMediumRiskData() {
    return (
      label: 'Medium Risk',
      backgroundColor: const Color(0xFFFFE9D5),
      borderColor: const Color(0xFFFB8C00),
      textColor: const Color(0xFFA93E60),
      iconPath: 'assets/icons/medium_risk_face.svg',
    );
  }

  ({
    String label,
    Color backgroundColor,
    Color borderColor,
    Color textColor,
    String iconPath,
  })
  _buildLowRiskData() {
    return (
      label: 'Low Risk',
      backgroundColor: const Color(0xFFD7F5DD),
      borderColor: const Color(0xFF43A047),
      textColor: const Color(0xFF006E07),
      iconPath: 'assets/icons/low_risk_face.svg',
    );
  }

  ({
    String label,
    Color backgroundColor,
    Color borderColor,
    Color textColor,
    String iconPath,
  })
  _buildUnknownData() {
    return (
      label: 'Unknown',
      backgroundColor: const Color(0xFFE0E0E0),
      borderColor: const Color(0xFF757575),
      textColor: const Color(0xFF616161),
      iconPath: '',
    );
  }

  Widget _buildBadgeContent(
    ({
      String label,
      Color backgroundColor,
      Color borderColor,
      Color textColor,
      String iconPath,
    })
    badgeData,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (badgeData.iconPath.isNotEmpty) _buildBadgeIcon(badgeData.iconPath),
        const SizedBox(width: 4),
        _buildBadgeLabel(badgeData.label, badgeData.textColor),
      ],
    );
  }

  Widget _buildBadgeIcon(String iconPath) {
    return SvgPicture.asset(iconPath, height: 12, width: 12);
  }

  Widget _buildBadgeLabel(String label, Color textColor) {
    return Flexible(
      child: Text(
        label,
        style: AppTextStyles.badgeText.copyWith(color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
