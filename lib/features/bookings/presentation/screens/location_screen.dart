import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/bookings/domain/use_cases/check_distance.dart';
import 'package:fixit/features/bookings/presentation/screens/service_details.dart';
import 'package:fixit/features/bookings/presentation/widgets/location_widget.dart';
import 'package:fixit/features/service_provider/presentation/screen/current_location_providers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatelessWidget {
  final String providerId;
  final double latitude;
  final double longitude;

  const LocationScreen({
    super.key,
    required this.providerId,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    CheckDistance checkDistance = CheckDistance();
    print('latitude from details : $latitude');

    // Use nullable variables
    double? userLatitude;
    double? userLongitude;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Colors.blueAccent.withOpacity(0.05)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              child: LocationWidget(
                onPositionTapped: (LatLng value) {
                  userLongitude = value.longitude;
                  userLatitude = value.latitude;
                },
                latitude: latitude,
                longitude: longitude,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RoundButton(
                title: 'Update Service Location',
                onPressed: () {
                  print(userLongitude);
                  print(userLatitude);
                  if (userLatitude != null && userLongitude != null) {
                    bool isServicable = checkDistance.execute(
                        latitude, longitude, userLatitude!, userLongitude!);
                    if (isServicable) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ServiceDetailsScreen(
                                id: '',
                              )));
                    } else {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content:
                      //         Text('Provider is servicable on selected area'),
                      //     duration: Duration(
                      //         seconds:
                      //             2), // Duration for how long the Snackbar will be visible
                      //   ),
                      // );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Service unavailable'),
                            content: Text(
                                'Unfortunately, the selected provider does not service your area. Please try selecting a different provider or check back later.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('See Available Providers'),
                                onPressed: () {
                                  // Handle the 'Proceed' action
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          CurrentLocationProviders(
                                              latitude: userLatitude!,
                                              longitude: userLongitude!)));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    print('No location selected.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
