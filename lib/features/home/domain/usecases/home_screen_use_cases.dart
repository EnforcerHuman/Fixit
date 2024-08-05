import 'package:fixit/features/service_provider/presentation/screen/profession_specific_provider_screen.dart';
import 'package:fixit/features/service_provider/presentation/screen/service_provider_details_screen.dart';
import 'package:fixit/features/service_provider/presentation/screen/service_provider_listing_screen.dart';
import 'package:fixit/features/services/data/data_sources/service_remote_repository.dart';
import 'package:fixit/features/services/presentation/screens/service_listing_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenUseCases {
  void navigateToServiceListing(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => const ServiceListingScreen(),
    ));
  }

  void navigateToProfessionSpecificProvider(
      BuildContext context, String profession) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) =>
          ProfessionSpecificProviderScreen(profession: profession),
    ));
  }

  void navigateToServiceProviderListing(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => const ServiceProviderListingScreen(),
    ));
  }

  void navigateToProviderDetails(BuildContext context, String id) {
    ServiceRemoteRepository().getServices();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => PlumberProfileScreen(id: id),
    ));
  }
}
