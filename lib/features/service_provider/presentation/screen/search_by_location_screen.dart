import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/bookings/presentation/widgets/location_widget.dart';
import 'package:fixit/features/service_provider/domain/usecases/search_by_location_screen_use_cases.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchByLocationScreen extends StatelessWidget {
  const SearchByLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RoundButton(
                title: 'Check Availability',
                onPressed: () {
                  if (userLongitude == null || userLongitude == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please select a place')));
                  } else {
                    SearchByLocationScreenUseCases
                        searchByLocationScreenUseCases =
                        SearchByLocationScreenUseCases();
                    searchByLocationScreenUseCases.onCheckAvailability(
                        userLongitude!, context, userLatitude!);
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
