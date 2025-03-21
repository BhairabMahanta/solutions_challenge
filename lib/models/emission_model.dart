class EmissionModel {
  double distance;
  double emissionFactor;

  EmissionModel({required this.distance, required this.emissionFactor});

  double calculateEmissions() {
    double emissions = distance * emissionFactor;
    print("Calculated emissions: $emissions");
    return emissions;
  }
}
