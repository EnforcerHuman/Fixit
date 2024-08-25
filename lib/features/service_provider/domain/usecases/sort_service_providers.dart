class SortServiceProviders {
  List<Map<String, dynamic>> sortByHourlyPay(
      List<Map<String, dynamic>> providers) {
    return providers
      ..sort((a, b) {
        // Convert hourlyPay to double for comparison
        final hourlyPayA =
            double.tryParse(a['hourlyPay'] as String? ?? '') ?? 0.0;
        final hourlyPayB =
            double.tryParse(b['hourlyPay'] as String? ?? '') ?? 0.0;
        return hourlyPayA.compareTo(hourlyPayB);
      });
  }
}
