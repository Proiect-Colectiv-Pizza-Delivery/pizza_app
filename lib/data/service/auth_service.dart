import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/data/service/api_service.dart';

class AuthService extends ApiService{
  AuthService(super.dio);

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