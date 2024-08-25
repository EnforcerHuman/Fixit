// ignore_for_file: use_build_context_synchronously

import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/common/common_widgets/text_editing_field.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/bookings/data/model/adress_model.dart';
import 'package:fixit/features/bookings/presentation/bloc/bookig_bloc/booking_bloc.dart';
import 'package:fixit/features/bookings/presentation/widgets/custom_calender.dart';
import 'package:fixit/features/main_navigation/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AdressCollectionPage extends StatelessWidget {
  const AdressCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController houseNumberController = TextEditingController();
    TextEditingController streetNumberController = TextEditingController();
    TextEditingController complteAdressController = TextEditingController();
    String bookingDate = DateTime.now().toIso8601String();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Wiring Installation'),
      ),
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingDataSubmited) {
            _showSubmissionDialog(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter your location address',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextEditingField(
                      controller: houseNumberController,
                      hintText: 'enter house number'),
                  const SizedBox(height: 16),
                  TextEditingField(
                      controller: streetNumberController,
                      hintText: 'enter street number'),
                  const SizedBox(height: 16),
                  TextEditingField(
                      controller: complteAdressController,
                      hintText: 'enter complte adress'),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: CustomCalendar(
                      onDateChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        if (args.value is DateTime) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(args.value);
                          bookingDate = formattedDate;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: RoundButton(
                        title: 'submit',
                        onPressed: () async {
                          AddressModel adress = AddressModel(
                              completeAddress: complteAdressController.text,
                              houseNumber: houseNumberController.text,
                              streetNumber: streetNumberController.text);
                          String username =
                              await AuthLocalDataService.getUserName();
                          context
                              .read<BookingBloc>()
                              .add(UpdateUserName(username));
                          context.read<BookingBloc>().add(UpdateAdress(adress));
                          context
                              .read<BookingBloc>()
                              .add(UpdateBookingDateTime(bookingDate));
                          context.read<BookingBloc>().add(SubmitBookingData());
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void _showSubmissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Booking Request Submitted'),
        content: const Text(
          'Your request has been sent to the service provider. We will update you once your request has been completed.',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const MainScreen()),
                (route) => false,
              );
            },
          ),
        ],
      );
    },
  );
}
