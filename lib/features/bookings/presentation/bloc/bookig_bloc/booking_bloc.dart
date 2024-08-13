import 'package:bloc/bloc.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/bookings/data/data_source/booking_remote_data_source.dart';
import 'package:fixit/features/bookings/data/model/adress_model.dart';
import 'package:fixit/features/bookings/data/model/booking_model.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRemotedataSource bookingRemotedataSource;
  BookingBloc(this.bookingRemotedataSource) : super(BookingInitial()) {
    String createdAt = DateFormat('yyyy-MM-dd').format(DateTime.now());
    BookingModel booking = BookingModel(
        id: '', // Unique identifier for the booking
        serviceProviderId: '', // Unique identifier for the service provider
        serviceProviderName: '', // Name of the service provider
        userId: '', // Unique identifier for the user
        userName: '', // Name of the user
        userContact: '', // Contact information for the user
        serviceId: '', // Unique identifier for the service
        serviceName: '', // Name of the service
        bookingDateTime: '', // Date and time of the booking
        createdAt: createdAt, // Date and time when the booking was created
        status: 'Requested', // Status of the booking
        workDetails: '', // Details of the work to be done
        imageLink: '', // Link to an image related to the book ing
        paymentStatus: 'pending', // Payment status
        // totalAmount: '', // Payment method
        cancellationReason: null, // Reason for cancellation (if any)
        cancellationDate:
            null, // Date when the booking was canceled (if applicable)
        providerContact: '', // Contact information for the service provider
        serviceLocation: '', // Location where the service will be provided
        timeSlot: null, // Time slot for the service (if applicable)
        notes: '', // Additional notes or special requests
        statusUpdatedAt: DateTime.now(),
        address: AddressModel(
            houseNumber: '', streetNumber: '', completeAddress: ''),
        // hourlyPayment: '',
        paymentMethod: '',
        hourlyPayment: '',
        totalPayment: '' // Timestamp when the status was last updated
        );

    on<BookingEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UpdateBookingId>((event, emit) {
      booking = booking.copyWith(id: event.bookingId);
    });
    on<UpdateServiceProviderId>((event, emit) {
      booking = booking.copyWith(serviceProviderId: event.serviceProviderId);
      print('service provider iD :');
      print(booking.serviceProviderId);
    });
    on<UpdateServiceProviderName>((event, emit) {
      booking =
          booking.copyWith(serviceProviderName: event.serviceProviderName);
    });
    on<UpdateUserId>((event, emit) {
      booking = booking.copyWith(userId: event.userId);
    });
    on<UpdateUserName>((event, emit) {
      booking = booking.copyWith(userName: event.userName);
    });
    on<UpdateserviceName>((event, emit) {
      booking = booking.copyWith(serviceName: event.serviceName);
    });
    on<UpdateBookingDateTime>((event, emit) {
      booking = booking.copyWith(bookingDateTime: event.bookingDate);
    });
    on<UpdateBookingcreatedAt>((event, emit) {
      booking = booking.copyWith(createdAt: event.bookingCreatedAt);
    });
    on<UpdateBookingStatus>((event, emit) {
      booking = booking.copyWith(status: event.bookingStatus);
    });
    on<UpdateWorkDetails>((event, emit) {
      booking = booking.copyWith(workDetails: event.workDetails);
    });
    on<UpdateImageLink>((event, emit) {
      booking = booking.copyWith(imageLink: event.imageLink);
    });
    on<UpdateAdress>((event, emit) {
      booking = booking.copyWith(address: event.adress);
    });
    on<UpdateHourlyPayment>((event, emit) {
      booking = booking.copyWith(hourlyPayment: event.hourlyPayment);
    });
    on<SubmitBookingData>((event, emit) async {
      String userId = await AuthLocalDataService.getUserId();
      String userName = await AuthLocalDataService.getUserName();
      booking = booking.copyWith(userName: userName);
      booking = booking.copyWith(userId: userId);
      try {
        bookingRemotedataSource.storeBookingDetails(booking);
        emit(BookingDataSubmited());
      } catch (e) {
        print(e);
      }
    });
  }
}
