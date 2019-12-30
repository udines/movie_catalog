class Session {
  Session(this.success, this.sessionId);

  Session.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool;
    sessionId = json['session_id'] as String;
  }

  bool success;
  String sessionId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['session_id'] = sessionId;
    return data;
  }
}
