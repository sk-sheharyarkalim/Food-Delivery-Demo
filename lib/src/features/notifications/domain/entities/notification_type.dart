/// Categories of notifications, used to pick an icon and color in the UI.
enum NotificationType {
  order,
  promo,
  system;

  String get value => name;

  static NotificationType fromValue(String? value) {
    return NotificationType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => NotificationType.system,
    );
  }
}
