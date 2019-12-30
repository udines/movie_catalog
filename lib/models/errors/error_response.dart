class ErrorResponse {
  ErrorResponse(this.statusMessage, this.statusCode);

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_message'] as String;
    statusCode = json['status_code'] as int;
  }

  String statusMessage;
  int statusCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_message'] = statusMessage;
    data['status_code'] = statusCode;
    return data;
  }
}
