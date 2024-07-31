class Service {
  final String name;
  final String imageUrl;

  Service({required this.imageUrl, required this.name});

  factory Service.fromMap(Map<String, dynamic> data, String documentId) {
    return Service(
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? '', // Use empty string if name is null
    );
  }
}
