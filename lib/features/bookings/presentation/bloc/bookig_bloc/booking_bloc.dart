import 'package:bloc/bloc.dart';
import 'package:fixit/features/bookings/data/data_source/booking_remote_data_source.dart';
import 'package:fixit/features/bookings/data/model/adress_model.dart';
import 'package:fixit/features/bookings/data/model/booking_model.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    BookingModel booking = BookingModel(
      id: '', // Unique identifier for the booking
      serviceProviderId: '', // Unique identifier for the service provider
      serviceProviderName: '', // Name of the service provider
      userId: '', // Unique identifier for the user
      userName: '', // Name of the user
      userContact: '', // Contact information for the user
      serviceId: '', // Unique identifier for the service
      serviceName: '', // Name of the service
      bookingDateTime: DateTime.now(), // Date and time of the booking
      createdAt: DateTime.now(), // Date and time when the booking was created
      status: 'Requested', // Status of the booking
      workDetails: '', // Details of the work to be done
      imageLink: '', // Link to an image related to the booking
      paymentStatus: 'pending', // Payment status
      paymentMethod: 'not specified', // Payment method
      cancellationReason: null, // Reason for cancellation (if any)
      cancellationDate:
          null, // Date when the booking was canceled (if applicable)
      providerContact: '', // Contact information for the service provider
      serviceLocation: '', // Location where the service will be provided
      timeSlot: null, // Time slot for the service (if applicable)
      notes: '', // Additional notes or special requests
      statusUpdatedAt: DateTime.now(),
      address: AddressModel(
          houseNumber: '',
          streetNumber: '',
          completeAddress: ''), // Timestamp when the status was last updated
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
      booking = booking.copyWith(serviceName: event.serviceProviderName);
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
      BookingRemotedataSource bookingRemotedataSource =
          BookingRemotedataSource();
      bookingRemotedataSource.storeBookingDetails(booking);
    });
  }
}
