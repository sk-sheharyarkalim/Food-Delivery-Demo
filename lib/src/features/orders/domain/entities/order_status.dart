enum OrderStatus {
  pending,
  preparing,
  onTheWay,
  delivered,
  cancelled;

  String get value => name;

  static OrderStatus fromValue(String? value) {
    return OrderStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => OrderStatus.pending,
    );
  }
}
