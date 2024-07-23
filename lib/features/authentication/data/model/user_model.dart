import 'package:fixit/features/authentication/data/model/service_history_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? address;
  final List<ServiceHistoryItem>? serviceHistory;
  final bool isServiceProvider;
  final Map<String, dynamic> preferences;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.address = '',
    this.serviceHistory = const [],
    this.isServiceProvider = false,
    this.preferences = const {},
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    List<ServiceHistoryItem>? serviceHistory,
    double? rating,
    bool? isServiceProvider,
    Map<String, dynamic>? preferences,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      serviceHistory: serviceHistory ?? this.serviceHistory,
      isServiceProvider: isServiceProvider ?? this.isServiceProvider,
      preferences: preferences ?? this.preferences,
    );
  }

  // You might also want to add toJson and fromJson methods for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'serviceHistory': serviceHistory,
      'isServiceProvider': isServiceProvider,
      'preferences': preferences,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      serviceHistory: List<ServiceHistoryItem>.from(json['serviceHistory']),
      isServiceProvider: json['isServiceProvider'],
      preferences: json['preferences'],
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, address: $address, serviceHistory: $serviceHistory,  isServiceProvider: $isServiceProvider, preferences: $preferences)';
  }
}
