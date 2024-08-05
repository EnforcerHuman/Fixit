import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/bookings/presentation/bloc/bookig_bloc/booking_bloc.dart';
import 'package:fixit/features/bookings/presentation/screens/adress_collection_page.dart';
import 'package:fixit/features/bookings/presentation/widgets/custom_service_card.dart';
import 'package:fixit/features/bookings/presentation/widgets/upload_file_widget.dart';
import 'package:fixit/features/service_provider/presentation/bloc/provider_details_bloc/provider_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String id;
  const ServiceDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // context.read<ProviderDetailsBloc>().add(GetProviderDetails(id));
    TextEditingController detailsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Selected Service'),
      ),
      body: BlocBuilder<ProviderDetailsBloc, ProviderDetailsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: state is ProviderDetailsLoaded
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            CustomServiceCard(
                                price: state.providerDetails['hourlyPay'],
                                serviceType:
                                    state.providerDetails['serviceArea']),
                            const SizedBox(height: 20),
                            const Text(
                                'Provide Specific Instructions or Details'),
                            const TextField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: 'Write here...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            UploadFileWidget(
                                label: 'Upload Picture ',
                                onTap: () {},
                                color: Colors.blueAccent,
                                boxText: 'upload')
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RoundButton(
                          title: 'Next',
                          onPressed: () {
                            context
                                .read<BookingBloc>()
                                .add(UpdateWorkDetails(detailsController.text));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    const AdressCollectionPage()));
                          },
                        ),
                      ),
                    ],
                  )
                : const Text('NO PROVIDER'),
          );
        },
      ),
    );
  }
}
