import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/common/common_widgets/text_editing_field.dart';
import 'package:fixit/features/bookings/data/model/adress_model.dart';
import 'package:fixit/features/bookings/presentation/bloc/bookig_bloc/booking_bloc.dart';
import 'package:fixit/features/bookings/presentation/widgets/custom_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdressCollectionPage extends StatelessWidget {
  const AdressCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController houseNumberController = TextEditingController();
    TextEditingController streetNumberController = TextEditingController();
    TextEditingController complteAdressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Wiring Installation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your location address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextEditingField(
                  controller: houseNumberController,
                  hintText: 'enter house number'),
              SizedBox(height: 16),
              TextEditingField(
                  controller: streetNumberController,
                  hintText: 'enter street number'),
              TextEditingField(
                  controller: complteAdressController,
                  hintText: 'enter complte adress'),
              SizedBox(height: 16),
              _buildInputField('Complete Address', 'Enter complete address'),
              SizedBox(height: 16),
              SizedBox(
                height: 300, // Set an appropriate height for CustomCalendar
                child: CustomCalendar(),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: RoundButton(
                    title: 'Next',
                    onPressed: () {
                      AddressModel adress = AddressModel(
                          completeAddress: complteAdressController.text,
                          houseNumber: houseNumberController.text,
                          streetNumber: streetNumberController.text);
                      context.read<BookingBloc>().add(UpdateAdress(adress));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }
}
