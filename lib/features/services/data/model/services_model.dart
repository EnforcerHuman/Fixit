class ServicesModel {
  final String name;
  final String imageUrl;

  ServicesModel({required this.imageUrl, required this.name});

  factory ServicesModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ServicesModel(
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? '', // Use empty string if name is null
    );
  }
}
