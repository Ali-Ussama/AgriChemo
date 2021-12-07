
abstract class BaseResponse{

  dynamic _targetUrl;
  bool? _success;
  Error? _error;
  bool? _unAuthorizedRequest;

  dynamic get targetUrl => _targetUrl;

  bool? get success => _success;

  Error? get error => _error;

  bool? get unAuthorizedRequest => _unAuthorizedRequest;

  void fromJson(Map<String,dynamic> json){
    _targetUrl = json["targetUrl"];
    _success = json["success"];
    _error = json["error"] != null ? Error.fromJson(json['error']) : null;
    _unAuthorizedRequest = json["unAuthorizedRequest"];
  }
}

class Error {
  int? _code;
  String? _message;
  String? _details;

  get code => _code;

  get message => _message;

  get details => _details;

  Error({int? code, String? message, String? details}) {
    _code = code;
    _message = message;
    _details = details;
  }

  Error.fromJson(Map<String,dynamic> json) {
    _code = json["code"];
    _message = json["message"];
    _details = json["details"];
  }
}
