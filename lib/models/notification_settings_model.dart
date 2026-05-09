enum NotificationStyle { empathetic, stoic, aggressive }

class NotificationSettingsModel {
  final bool isEnabled;
  final int hour;
  final int minute;
  final NotificationStyle style;

  NotificationSettingsModel({
    this.isEnabled = true,
    this.hour = 8,
    this.minute = 30,
    this.style = NotificationStyle.stoic,
  });

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'hour': hour,
      'minute': minute,
      'style': style.index,
    };
  }

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      isEnabled: json['isEnabled'] ?? true,
      hour: json['hour'] ?? 8,
      minute: json['minute'] ?? 30,
      style: NotificationStyle.values[json['style'] ?? 1],
    );
  }

  NotificationSettingsModel copyWith({
    bool? isEnabled,
    int? hour,
    int? minute,
    NotificationStyle? style,
  }) {
    return NotificationSettingsModel(
      isEnabled: isEnabled ?? this.isEnabled,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      style: style ?? this.style,
    );
  }
}
