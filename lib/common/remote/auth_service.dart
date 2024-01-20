import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/data/prefs_constants.dart';
import 'package:pizza_app/data/repository/secure_local_storage/secure_local_storage.dart';

class AuthService{
  final String authUrl = "/auth";
  final dio = Dio();

  AuthService(){
    dio.options.baseUrl = "https://backend-vkyvjdcngq-uc.a.run.app/api";
  }

  Future<void> signUp(User user) async {
    dio.options.headers["Device-id"] = getDeviceId();
    var response = await dio.post("$authUrl/signup", data: user.toJson());
  }

  Future<User> logIn(String userName, String password) async {

    dio.options.headers["Device-id"] = await getDeviceId();
    var response = await dio.post("$authUrl/login", data: {
      "username": userName,
      "password": password,
    });

    SecureLocalStorage().writeData(PrefsConstants.secureRefreshToken, response.data['refreshToken']);
    SecureLocalStorage().writeData(PrefsConstants.secureKeyIdToken, response.data['token']);

    print(response);

    return User.fromJson(response.data);
  }

  Future<String> getUserToken() async {
    String? token = await SecureLocalStorage().readData(PrefsConstants.secureRefreshToken);
    print("refresh token is $token");
    dio.options.headers["Token"] = "Bearer $token";
    dio.options.headers["Device-id"] = await getDeviceId();

    var response = await dio.post(
      "$authUrl/refreshtoken",
    );

    return response.data["accessToken"];
  }


  Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
        String deviceId = androidInfo.id;
        print('Device ID (Android): $deviceId');
        return deviceId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
        String deviceId = iosInfo.identifierForVendor ?? '';
        print('Device ID (iOS): $deviceId');
        return deviceId;
      }
      return "";
    } catch (e) {
      print('Error obtaining device ID: $e');
      return "";
    }
  }
}
