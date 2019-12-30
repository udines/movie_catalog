class RequestToken {
  RequestToken(this.success, this.expiresAt, this.requestToken);

  RequestToken.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool;
    expiresAt = json['expires_at'] as String;
    requestToken = json['request_token'] as String;
  }

  bool success;
  String expiresAt;
  String requestToken;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['expires_at'] = expiresAt;
    data['request_token'] = requestToken;
    return data;
  }
}
