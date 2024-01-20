import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/common/remote/prefs_constants.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/data/repository/secure_local_storage.dart';

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

    SecureLocalStorage().writeData(PrefsConstants.secureKeyIdToken, response.data["accessToken"]);
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

  void sendAccountInformation(GoogleSignInAccount account) async{
    var auth = await account.authentication;
    var deviceInfo = DeviceInfoPlugin();
    String? deviceId;
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id; // unique ID on Android
    }
    Map<String, String> data = {
      "displayName": account.displayName.toString(),
      "email": account.email,
      "id": account.id,
      "serverAuthCode": account.serverAuthCode.toString(),
      "idToken": auth.idToken.toString(),
      "accessToken": auth.accessToken.toString(),
      "deviceId": deviceId.toString(),
    };
    log(data.toString());
    var response = await dio.post(authUrl, data: data);
    log(response.data.toString());
  }
}
