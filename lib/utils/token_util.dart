import 'package:tarek_agro/utils/constants.dart';
import 'package:tarek_agro/utils/jwt.dart';
import 'package:tarek_agro/utils/preference_manger.dart';

class TokenUtil {
  static String? _token = '';

  static Future<void> loadTokenToMemory() async {
    _token = await PreferenceManager.getInstance()?.getString(Constants.token);
  }

  static String? getTokenFromMemory() {
    return _token;
  }

  static void saveToken(String token) {
    _token = token;
    PreferenceManager.getInstance()?.saveString(Constants.token, token);
  }

  static void clearToken() {
    PreferenceManager.getInstance()?.remove(Constants.token);
    _token = '';
  }

  static bool isTokenExpired(){
    return Jwt.isExpired(getTokenFromMemory());
  }
}
