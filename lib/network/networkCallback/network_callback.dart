import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:tarek_agro/network/client/api_client.dart';
import 'package:tarek_agro/utils/enums.dart';
import 'package:http/http.dart';

class NetworkCall {
  static Future<Map<String, dynamic>> makeCall({
    String endPoint = "",
    HttpMethod? method,
    dynamic requestBody,
    Map<String, dynamic>? queryParams,
    bool isMultipart = false,
  }) async {
    try {
      Response response;
      if (method == HttpMethod.GET) {
        response = (await ApiClient.getRequest(endPoint, queryParams));
      } else {
        response = (await ApiClient.postRequest(endPoint, requestBody,
            isMultipart: isMultipart));
      }

      if (response.statusCode == NetworkStatusCodes.ok200.value) {
            //Api logger
            log("Api Response: ${response.body}");
            return jsonDecode(response.body) as Map<String, dynamic>;
          } else if (response.statusCode ==
              NetworkStatusCodes.serverInternalError.value || response.statusCode == NetworkStatusCodes.badRequest.value) {
            //Api logger
            log(
                "API Error: ${response.statusCode} - ${response.reasonPhrase} - ${response.body}");
            return jsonDecode(response.body) as Map<String, dynamic>;
          } else if(response.statusCode == NetworkStatusCodes.unAuthorizedUser.value){

        var result = jsonDecode(response.body) as Map<String, dynamic>;
        result['error']['code'] = response.statusCode;

        //Api logger
        log(
            "API Error: ${response.statusCode} - ${response.reasonPhrase} - $result");
        return result;
      }else {
            //Api logger
        log(
                "API Error: ${response.statusCode} - ${response.reasonPhrase} - ${response.body}");
            return {
              "success": false,
              "error": {
                "code": response.statusCode,
                "message": response.reasonPhrase,
                "details": ""
              }
            };
          }
    }on SocketException catch (_) {
      return {
        "success": false,
        "error": {
          "code": 0,
          "message": "No internet connection, please check you network and try again",
          "details": ""
        }
      };
    }
  }
}
