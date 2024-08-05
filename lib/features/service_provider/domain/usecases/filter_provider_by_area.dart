import 'package:fixit/features/bookings/data/distance_calculator.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_data_source.dart';

class GetProvidersWithinRadius {
  final ServiceProviderDataSource repository;

  GetProvidersWithinRadius(this.repository);

  Future<List<Map<String, dynamic>>> execute(
      double userLat, double userLon, double radiusInKm) async {
    // Convert radius from kilometers to meters
    double radiusInMeters = radiusInKm * 1000;

    // Fetch all providers
    List<Map<String, dynamic>> providers =
        await repository.getServiceProvidersStream().first;

    // Filter providers within the specified radius
    List<Map<String, dynamic>> filteredProviders = providers.where((provider) {
      // Check if provider and location exist
      if (provider == null || provider['location'] == null) {
        return false;
      }

      var location = provider['location'];
      // Check if latitude and longitude exist and are of the correct type
      if (location['latitude'] == null || location['longitude'] == null) {
        return false;
      }

      double providerLat = double.parse(location['latitude'].toString());
      double providerLon = double.parse(location['longitude'].toString());

      double distance = DistanceCalculator.calculateDistance(
          userLat, userLon, providerLat, providerLon);

      print('Provider: ${provider['name']}, Distance: ${distance / 1000} km');

      return distance <= radiusInMeters;
    }).toList();

    print('Total providers: ${providers.length}');
    print('Filtered providers: ${filteredProviders.length}');

    return filteredProviders;
  }
}
