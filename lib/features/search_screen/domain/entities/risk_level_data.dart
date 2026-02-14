enum RiskLevel {
  unknown('Unknown'),
  lowRisk('Low Risk'),
  mediumRisk('Medium Risk'),
  highlyToxic('Highly Toxic');

  final String name;

  const RiskLevel(this.name);
}
