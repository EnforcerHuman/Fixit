class ServiceHistoryItem {
  final String id;
  final String serviceType;
  final DateTime date;
  final String providerName;
  final String providerId;
  final double cost;
  final String status;
  final double rating;
  final String? comment;

  ServiceHistoryItem({
    required this.id,
    required this.serviceType,
    required this.date,
    required this.providerName,
    required this.providerId,
    required this.cost,
    required this.status,
    this.rating = 0.0,
    this.comment,
  });

  ServiceHistoryItem copyWith({
    String? id,
    String? serviceType,
    DateTime? date,
    String? providerName,
    String? providerId,
    double? cost,
    String? status,
    double? rating,
    String? comment,
  }) {
    return ServiceHistoryItem(
      id: id ?? this.id,
      serviceType: serviceType ?? this.serviceType,
      date: date ?? this.date,
      providerName: providerName ?? this.providerName,
      providerId: providerId ?? this.providerId,
      cost: cost ?? this.cost,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceType': serviceType,
      'date': date.toIso8601String(),
      'providerName': providerName,
      'providerId': providerId,
      'cost': cost,
      'status': status,
      'rating': rating,
      'comment': comment,
    };
  }

  factory ServiceHistoryItem.fromJson(Map<String, dynamic> json) {
    return ServiceHistoryItem(
      id: json['id'],
      serviceType: json['serviceType'],
      date: DateTime.parse(json['date']),
      providerName: json['providerName'],
      providerId: json['providerId'],
      cost: json['cost'],
      status: json['status'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }

  @override
  String toString() {
    return 'ServiceHistoryItem(id: $id, serviceType: $serviceType, date: $date, providerName: $providerName, providerId: $providerId, cost: $cost, status: $status, rating: $rating, comment: $comment)';
  }
}
