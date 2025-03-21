import '../models/emission_model.dart';

double calculateEmissions(double distance, double factor) {
  print("Calculating emissions with distance: $distance and factor: $factor");
  EmissionModel model =
      EmissionModel(distance: distance, emissionFactor: factor);
  return model.calculateEmissions();
}
