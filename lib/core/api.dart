import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseUrl = "https://api.weatherapi.com/v1";
const int isbeta = 0;

const Map<String, dynamic> defaultHEADERS = {
  "Content-Type": "application/json"
};

class Api {
  final Dio _dio = Dio();
  Api() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = defaultHEADERS;
    _dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }

  Dio get sendRequest => _dio;
}
