import 'dart:math';

import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/common/common_widgets/text_editing_field.dart';
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
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const MainScreen()),
                (route) => false);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Booking Request submitted'),
                  content: const Text(
                      'Your request has been sent to service provider . We will update you once your request has been completed'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        // Handle the 'Proceed' action
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
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
                          print(bookingDate);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: RoundButton(
                        title: 'submit',
                        onPressed: () {
                          AddressModel adress = AddressModel(
                              completeAddress: complteAdressController.text,
                              houseNumber: houseNumberController.text,
                              streetNumber: streetNumberController.text);
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
