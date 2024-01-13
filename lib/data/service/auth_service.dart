import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/data/service/api_service.dart';

class AuthService extends ApiService{
  AuthService(super.dio);

  void sendAccountInformation(GoogleSignInAccount account) async{
    var auth = await account.authentication;
    Map<String, String> data = {
      "displayName": account.displayName.toString(),
      "email": account.email,
      "id": account.id,
      "serverAuthCode": account.serverAuthCode.toString(),
      "idToken": auth.idToken.toString(),
      "accessToken": auth.accessToken.toString(),
    };
    log(data.toString());
    var response = await dio.post(authUrl, data: data);
    log(response.data.toString());
  }
}