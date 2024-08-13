class PaymentOptions {
  final String key;
  final int amount;
  final String name;
  final String description;
  final Map<String, String> prefill;
  final Map<String, List<String>> external;

  PaymentOptions({
    required this.key,
    required this.amount,
    required this.name,
    required this.description,
    required this.prefill,
    required this.external,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'amount': amount,
      'name': name,
      'description': description,
      'prefill': prefill,
      'external': external,
    };
  }
}
