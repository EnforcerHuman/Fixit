import 'package:fixit/features/bookings/presentation/bloc/top_nav_bar_bloc/top_nav_bar_bloc.dart';
import 'package:fixit/features/bookings/presentation/screens/accepted_booking_screen.dart';
import 'package:fixit/features/bookings/presentation/screens/completed_booking_screen.dart';
import 'package:fixit/features/bookings/presentation/screens/requested_booking_screen.dart';
import 'package:fixit/features/bookings/presentation/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBookingsScreen extends StatelessWidget {
  final List<Widget> pages = [
    const RequestedBookingScreen(),
    const UpcomingBookingsScreen(),
    const CompletedBookingScreen(),
    // const CancelledBookingsScreen()
  ];

  AllBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopNavBarBloc(),
      child: BlocBuilder<TopNavBarBloc, TopNavState>(
        builder: (context, state) {
          return Scaffold(
            appBar: TopNavBar(
              selectedIndex: state.selectedIndex,
              onItemTapped: (index) {
                context.read<TopNavBarBloc>().add(NavigateToIndex(index));
              },
            ),
            body: pages[state.selectedIndex],
          );
        },
      ),
    );
  }
}
