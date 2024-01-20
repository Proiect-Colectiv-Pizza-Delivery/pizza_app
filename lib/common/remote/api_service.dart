import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pizza_app/common/remote/auth_service.dart';
import 'package:pizza_app/common/remote/interceptors/auth_interceptor.dart';

abstract class ApiService {
  final Dio dio;
  final AuthInterceptor? _authInterceptor;

  ApiService(
    this.dio,
    this._authInterceptor,
  ) {
    initDioOptions();
  }

  initDioOptions() async {
    dio.options.baseUrl = 'https://backend-vkyvjdcngq-uc.a.run.app/api';
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);
    dio.interceptors.clear();
    if (_authInterceptor != null) {
      dio.interceptors.add(_authInterceptor!);
    }
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
  void errorHandler(DioException e, ErrorInterceptorHandler handler) async {
    print(e);
  }
}
