import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:pizza_app/data/prefs_constants.dart';
import 'package:pizza_app/data/repository/secure_local_storage/secure_local_storage.dart';

import '../auth_service.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final SecureLocalStorage _secureLocalStorage;
  final AuthService _authService;
  final VoidCallback _authCallback;
  final Dio _dio;

  AuthInterceptor(this._dio, this._secureLocalStorage, this._authService,
      this._authCallback);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = await getHeaders();
    handler.next(options);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String? newToken = await refreshToken();
      if (newToken == null) {
        //token could not be refreshed notify the callback to logout the user
        _authCallback.call();
        return;
      }
      handler.resolve(await requestRetry(err.requestOptions, newToken));
    } else {
      handler.next(err);
    }
  }

  Future<Response> requestRetry(
      RequestOptions requestOptions, String newToken) async {
    log(
      "requestRetry.",
    );
    //retry the request with a new token
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      contentType: requestOptions.contentType,
      responseType: requestOptions.responseType,
    );
    options.headers?['Authorization'] = 'Bearer $newToken';

    // Retry the request
    return _dio.request(
      requestOptions.path,
      options: options,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
    );
  }

  Future<String?> refreshToken() async {
    log(
      "refreshToken.",
    );
    String? token;
    try {
      token = await _authService.getUserToken();
    } catch (e) {
      log(
        "refreshToken. Message: New token couldn't be generated. $e",
      );
      return Future.value(token);
    }
    if (token == null) {
      log(
        "refreshToken. Message: Token is null. A new token couldn't be generate.",
      );
      return Future.value(token);
    }
    _secureLocalStorage.writeData(PrefsConstants.secureKeyIdToken, token);
    return Future.value(token);
  }

  getHeaders() async {
    String? token =
        await _secureLocalStorage.readData(PrefsConstants.secureKeyIdToken);
    if (token == null || token.isEmpty) {
      log(
        "Token not found in local storage.",
      );
      token = await refreshToken();
    }
    String deviceId = await getDeviceId();
    return {
      "Content-Type": "application/json",
      "Token": "Bearer $token",
      "Device-id": deviceId
    };
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
