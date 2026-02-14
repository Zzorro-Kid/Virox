import '../../../../core/constants/app_constants.dart';

enum FirstAidTypeData {
  eye,
  inhaled,
  swallowed,
  skin;

  @override
  String toString() {
    switch (this) {
      case FirstAidTypeData.eye:
        return 'Eye';
      case FirstAidTypeData.inhaled:
        return 'Inhaled';
      case FirstAidTypeData.swallowed:
        return 'Swallowed';
      case FirstAidTypeData.skin:
        return 'Skin';
    }
  }

  String get iconPath {
    switch (this) {
      case FirstAidTypeData.eye:
        return AppIcons.eyeIcon;
      case FirstAidTypeData.inhaled:
        return AppIcons.lungsIcon;
      case FirstAidTypeData.swallowed:
        return AppIcons.mouthIcon;
      case FirstAidTypeData.skin:
        return AppIcons.handIcon;
    }
  }

}
