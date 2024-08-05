import 'package:fixit/features/bookings/domain/use_cases/check_distance.dart';
import 'package:fixit/features/bookings/presentation/bloc/location/location_bloc.dart';
import 'package:fixit/features/bookings/presentation/bloc/location/location_event.dart';
import 'package:fixit/features/bookings/presentation/bloc/location/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationWidget extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final ValueChanged<LatLng> onPositionTapped;

  const LocationWidget({
    super.key,
    this.latitude,
    this.longitude,
    required this.onPositionTapped,
  });

  @override
  Widget build(BuildContext context) {
    final CheckDistance _checkDistance = CheckDistance();

    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationInitial) {
          BlocProvider.of<LocationBloc>(context).add(GetLocationEvent());
          return Center(child: Text('Getting location...'));
        } else if (state is LocationLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LocationLoaded || state is LocationSelected) {
          LatLng position;
          if (state is LocationLoaded) {
            position = state.position;
          } else {
            position = (state as LocationSelected).selectedPosition;
          }

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: position,
              zoom: 14,
            ),
            markers: {
              Marker(
                markerId: MarkerId('current-location'),
                position: position,
              ),
            },
            onMapCreated: (GoogleMapController controller) {},
            onTap: (LatLng tappedPosition) async {
              // Invoke the onPositionTapped callback with the tapped position
              onPositionTapped(tappedPosition);

              // _checkDistance.execute(latitude, longitude,
              //     tappedPosition.latitude, tappedPosition.longitude);
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  tappedPosition.latitude, tappedPosition.longitude);
              print(placemarks);

              // Update the location with the new tapped position
              BlocProvider.of<LocationBloc>(context).add(SelectLocationEvent(
                  tappedPosition,
                  '${placemarks.first.name},${placemarks.first.thoroughfare},${placemarks.first.locality},${placemarks.first.street},${placemarks.first.postalCode}'));
            },
          );
        } else if (state is LocationError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }
}
