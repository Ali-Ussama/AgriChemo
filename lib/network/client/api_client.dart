import 'dart:developer';
import 'dart:io';
import 'package:tarek_agro/network/services_urls.dart';
import 'package:tarek_agro/singleton/settings_session.dart';
import 'package:tarek_agro/utils/token_util.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiClient {
  static Map<String, String> headers() {
    var mHeaders = {
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.connectionHeader: 'keep-alive',
      HttpHeaders.cacheControlHeader: 'no-cache',
      HttpHeaders.contentTypeHeader: 'application/json',
      "Abp.TenantId": '1'
    };
    mHeaders["Accept-Language"] = DataSettingsSession.instance().languageCode;
    mHeaders[".AspNetCore.Culture"] = DataSettingsSession.instance().languageCode;
    // loading auth token
    if (TokenUtil.getTokenFromMemory() != null && TokenUtil.getTokenFromMemory()!.isNotEmpty) {
      mHeaders[HttpHeaders.authorizationHeader] =
          "Bearer ${TokenUtil.getTokenFromMemory()}";
    }

    return mHeaders;
  }

  static Future<Response> getRequest(
      String endPoint, Map<String, dynamic>? queryParams) async {
    try{
      //create url with (baseUrl + endPoint) and query Params if any
      Uri url = Uri(
          scheme: ServicesURLs.developmentEnvironmentScheme,
          host: ServicesURLs.developmentEnvironmentWithoutHttp,
          port: ServicesURLs.developmentEnvironmentPort,
          path: endPoint,
          queryParameters: queryParams);

      //network logger
      log(url.toString() + "\n" + headers().toString());
      log(url.queryParameters.toString());
      //GET network request call
      final response = await http.get(url, headers: headers());
      return response;
    }on Exception {
      return Response("", 505,reasonPhrase: 'No Internet Connection');
    }
  }

  static Future<http.Response> postRequest(String endPoint, dynamic requestBody,
      {bool isMultipart = false}) async {
    try{
      //create url of (baseUrl + endPoint)
    String url = ServicesURLs.developmentEnvironment + endPoint;
    //network logger
    log(url + "\n" + headers().toString());
    if (requestBody != null) log(requestBody.toString());
    //POST network request call

    http.Response response;
    if (!isMultipart) {
      response = await http.post(Uri.parse(url),
          headers: headers(), body: requestBody);
    } else {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers())
        ..files.add(await http.MultipartFile.fromPath(
          '',
          requestBody.path,
        ));
      response = await http.Response.fromStream(await request.send());
    }

    return response;
    }on Exception {
      return Response("", 505,reasonPhrase: 'No Internet Connection');
    }
  }
}
