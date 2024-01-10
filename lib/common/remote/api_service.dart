import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

abstract class ApiService {
  final Dio dio;

  ApiService(
    this.dio,
  ) {
    initDioOptions();
  }

  initDioOptions() async {
    dio.options.baseUrl = 'https://backend-vkyvjdcngq-uc.a.run.app/api';
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);
    dio.interceptors.clear();
    dio.interceptors.addAll([
      //Also for more logging info the built in LogInterceptor
      // can be used instead of this custom one.
      RetryInterceptor(
        dio: dio,
        logPrint: print,
        retries: 3,
      ),
      InterceptorsWrapper(onError: errorHandler),
    ]);
  }

  // TODO: Make the error handler actually handle unintercepted errors
  void errorHandler(DioException e, ErrorInterceptorHandler handler) async {}
}
