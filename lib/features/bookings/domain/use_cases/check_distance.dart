import 'package:fixit/features/bookings/data/distance_calculator.dart';

class CheckDistance {
  bool execute(double lat1, double lon1, double lat2, double lon2) {
    double distance =
        DistanceCalculator.calculateDistance(lat1, lon1, lat2, lon2);
    if (distance <= 20000) {
      print('The first location is within 20 km of the second location.');
      return true;
    } else {
      print(
          'The first location is more than 20 km away from the second location.');
      return false;
    }
  }
}
