part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

class UpdateBookingId extends BookingEvent {
  final String bookingId;

  UpdateBookingId(this.bookingId);
}

class UpdateServiceProviderId extends BookingEvent {
  final String serviceProviderId;

  UpdateServiceProviderId(this.serviceProviderId);
}

class UpdateServiceProviderName extends BookingEvent {
  final String serviceProviderName;

  UpdateServiceProviderName(this.serviceProviderName);
}

class UpdateUserId extends BookingEvent {
  final String userId;

  UpdateUserId(this.userId);
}

class UpdateUserName extends BookingEvent {
  final String userName;

  UpdateUserName(this.userName);
}

class UpdateserviceName extends BookingEvent {
  final String serviceName;

  UpdateserviceName(this.serviceName);
}

class UpdateBookingDateTime extends BookingEvent {
  final DateTime bookingDate;

  UpdateBookingDateTime(this.bookingDate);
}

class UpdateBookingcreatedAt extends BookingEvent {
  final DateTime bookingCreatedAt;

  UpdateBookingcreatedAt(this.bookingCreatedAt);
}

class UpdateBookingStatus extends BookingEvent {
  final String bookingStatus;

  UpdateBookingStatus(this.bookingStatus);
}

class UpdateWorkDetails extends BookingEvent {
  final String workDetails;

  UpdateWorkDetails(this.workDetails);
}

class UpdateImageLink extends BookingEvent {
  final String imageLink;

  UpdateImageLink(this.imageLink);
}

class UpdateAdress extends BookingEvent {
  final AddressModel adress;

  UpdateAdress(this.adress);
}
