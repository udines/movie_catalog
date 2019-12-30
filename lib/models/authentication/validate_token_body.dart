class ValidateTokenBody {
  ValidateTokenBody(this.username, this.password, this.requestToken);

  ValidateTokenBody.fromJson(Map<String, dynamic> json) {
    username = json['username'] as String;
    password = json['password'] as String;
    requestToken = json['request_token'] as String;
  }

  String username;
  String password;
  String requestToken;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['request_token'] = requestToken;
    return data;
  }
}
