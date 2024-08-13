import 'package:firebase_core/firebase_core.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_phone_auth_services.dart';
import 'package:fixit/features/authentication/presentation/bloc/User/user_bloc.dart';
import 'package:fixit/features/authentication/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:fixit/features/bookings/data/data_source/booking_remote_data_source.dart';
import 'package:fixit/features/bookings/data/data_source/get_location.dart';
import 'package:fixit/features/bookings/domain/use_cases/booking_use_case.dart';
import 'package:fixit/features/bookings/presentation/bloc/accepted_bookings_bloc/accepted_bookings_bloc.dart';
import 'package:fixit/features/bookings/presentation/bloc/bookig_bloc/booking_bloc.dart';
import 'package:fixit/features/bookings/presentation/bloc/completed_booking_bloc/completed_bookings_bloc.dart';
import 'package:fixit/features/bookings/presentation/bloc/location/location_bloc.dart';
import 'package:fixit/features/bookings/presentation/bloc/requested_bookings_bloc/requested_bookings_bloc.dart';
import 'package:fixit/features/bookings/presentation/bloc/top_nav_bar_bloc/top_nav_bar_bloc.dart';
import 'package:fixit/features/home/presentation/screens/splash_screen.dart';
import 'package:fixit/features/main_navigation/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_bloc.dart';
import 'package:fixit/features/payment/data/razor_pay_remote_data_source.dart';
import 'package:fixit/features/payment/presentation/bloc/bloc/payment_bloc.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_data_source.dart';
import 'package:fixit/features/service_provider/data/data_sources/service_provider_search.dart';
import 'package:fixit/features/service_provider/domain/usecases/filter_provider_by_area.dart';
import 'package:fixit/features/service_provider/presentation/bloc/profession_specific_bloc/profession_specific_bloc.dart';
import 'package:fixit/features/service_provider/presentation/bloc/providers_by_location/providers_by_location_bloc.dart';
import 'package:fixit/features/service_provider/presentation/bloc/search_bloc/service_provider_search_bloc.dart';
import 'package:fixit/features/service_provider/presentation/bloc/service_provider_bloc/service_provider_bloc.dart';
import 'package:fixit/features/service_provider/presentation/bloc/provider_details_bloc/provider_details_bloc.dart';
import 'package:fixit/features/services/data/data_sources/service_remote_repository.dart';
import 'package:fixit/features/services/presentation/bloc/service_search_bloc/service_search_bloc.dart';
import 'package:fixit/features/services/presentation/bloc/services_bloc/services_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBIL2QGPyrbqyCXF9sCP_m0lrhvr6gK2oM",
      appId: "1:697886710494:android:773bddd5f8e39041c3004f",
      messagingSenderId: "697886710494",
      projectId: "fixit-1b8b8",
      storageBucket: "fixit-1b8b8.appspot.com",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(
            create: (context) => ForgotPasswordBloc(PhoneAuthentication())),
        BlocProvider(create: (context) => MainNavigationBloc()),
        BlocProvider(
            create: (context) =>
                ServiceProviderBloc(ServiceProviderDataSource())
                  ..add(GetServiceProvider())),
        BlocProvider(
            create: (context) =>
                ServicesBloc(ServiceRemoteRepository())..add(GetServices())),
        BlocProvider(
            create: (context) =>
                ProviderDetailsBloc(ServiceProviderDataSource())),
        BlocProvider(
            create: (context) =>
                ServiceProviderSearchBloc(ServiceProviderSearchDataSource())),
        BlocProvider(
            create: (context) => ServiceSearchBloc(ServiceRemoteRepository())),
        BlocProvider(
            create: (context) =>
                ProfessionSpecificBloc(ServiceProviderDataSource())),
        BlocProvider(
            create: (context) =>
                LocationBloc(getCurrentLocation: GetCurrentLocation())),
        BlocProvider(
            create: (context) =>
                LocationBloc(getCurrentLocation: GetCurrentLocation())),
        BlocProvider(
            create: (context) => ProvidersByLocationBloc(
                GetProvidersWithinRadius(ServiceProviderDataSource()))),
        BlocProvider(
            create: (context) => BookingBloc(BookingRemotedataSource())),
        BlocProvider(
            create: (context) => RequestedBookingsBloc(BookingUseCase())),
        BlocProvider(create: (context) => TopNavBarBloc()),
        BlocProvider(
            create: (context) => AcceptedBookingsBloc(BookingUseCase())),
        BlocProvider(create: (context) => PaymentBloc(RazorpayService())),
        BlocProvider(
            create: (context) => CompletedBookingsBloc(BookingUseCase()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
