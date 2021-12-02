import 'package:tarek_agro/extensions/enumeration.dart';

class HttpMethod extends Enum {
  HttpMethod(value) : super(value);

  static final HttpMethod GET = HttpMethod('GET');
  static final HttpMethod POST = HttpMethod('POST');
}

class NetworkStatusCodes extends Enum {
  NetworkStatusCodes(value) : super(value);

  static final UnAuthorizedUser = NetworkStatusCodes(401);
  static final BadRequest = NetworkStatusCodes(400);
  static final ServerInternalError = NetworkStatusCodes(500);
  static final OK_200 = NetworkStatusCodes(200);
}

class Sources extends Enum {
  Sources(id) : super(id);

  static final backOfficeSource = Sources(120);
  static final androidSource = Sources(121);
  static final iosSource = Sources(122);

}