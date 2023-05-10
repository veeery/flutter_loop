class NotificationModel {
  String? action;
  String? payload;

  NotificationModel({this.action, this.payload});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      action: json["action"],
      payload: json["payload"],
    );
  }

  NotificationModel.name(this.action, this.payload);

  Map<String, dynamic> toJson() {
    return {
      "action": action,
      "payload": payload,
    };
  }

  @override
  List<Object> get props => [action!, payload!];
}
