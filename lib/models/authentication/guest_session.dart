class GuestSession {
  GuestSession(this.success, this.guestSessionId, this.expiresAt);

  GuestSession.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool;
    guestSessionId = json['guest_session_id'] as String;
    expiresAt = json['expires_at'] as String;
  }

  bool success;
  String guestSessionId;
  String expiresAt;
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['guest_session_id'] = guestSessionId;
    data['expires_at'] = expiresAt;
    return data;
  }
}
