import 'dart:convert';
import 'package:dio/dio.dart';

class NetWork {
  final String _baseUrl = 'Hamada';
  Dio dio = Dio();

  Future<dynamic> getData(
      {String url, List<Map<String, dynamic>> headers}) async {
    var jsonResponse;
    dio.options.baseUrl = _baseUrl;
  headers == null ?null :  headers[0]['Authorization'] != null
        ? dio.options.headers = headers[0]
        : dio.options.headers.clear();

    try {
      final response = await dio.get('/$url');
      jsonResponse = _handelResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.DEFAULT == e.type) {
        if (e.message.contains('SocketException')) {
          return jsonResponse = 'internet';
        }
      }
    }
    return jsonResponse;
  }

  Future<dynamic> postData(
      {FormData formData, Map<String, dynamic> headers, String url}) async {
    dio.options.baseUrl = _baseUrl;
    headers != null
        ? dio.options.headers = headers
        : dio.options.headers.clear();

    var jsonResponse;
    Response response = await dio.post(url, data: formData);
    jsonResponse = json.decode(response.toString());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      jsonResponse = json.decode(response.toString());
      return jsonResponse;
    } else if (response == null) {
      return response;
    } else {
      return response;
    }
  }

  Future<dynamic> deleteData(
      {String url, List<Map<String, dynamic>> headers}) async {
    var jsonResponse;
    dio.options.baseUrl = _baseUrl;

    headers != null
        ? dio.options.headers = headers[0]
        : dio.options.headers.clear();

    Response response = await dio.delete('/$url').catchError((err) {});
    if (response.statusCode >= 200 && response.statusCode < 300) {
      jsonResponse = json.decode(response.toString());
      return jsonResponse;
    } else if (response == null) {
      return response;
    } else {
      return response;
    }
  }

  dynamic _handelResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.toString());
        return responseJson;
      case 400:
        var jsonResponse = 'unauth';
        return jsonResponse;
      case 401:
        var jsonResponse = 'unauth';
        return jsonResponse;
      case 403:
        var jsonResponse = 'unauth';
        return jsonResponse;
      case 500:
        var jsonResponse = 'server error';
        return jsonResponse;

      default:
        var jsonResponse = 'server error';
        return jsonResponse;
    }
  }
}
