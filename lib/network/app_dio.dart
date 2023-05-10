import 'package:dio/dio.dart';

class AppDio {
  static String baseUrl = "https://fcm.googleapis.com/fcm";

  static String keyNotification =
      "";

  final appDio = dio();

  static Options headers = Options(headers: {
    Headers.contentTypeHeader: "application/x-www-form-urlencoded",
    Headers.acceptHeader: "application/json",
  });

  static Options headersToken() {
    return Options(headers: {
      "Authorization": "key=AAAAhmko3rM:APA91bF7xJL0Bj_oMs9j5uWgyLmEPPShizukgvu6H5ldRc-i1gYbkiq1l87roTfR6iElQbNgD4gjl8Og6BjmXdRzVuLdNuWJoyEibYD9BKHqeCq7x2hYVCaQVHbUXvK7OvKqZB9o4Il4",
      Headers.contentTypeHeader: "application/x-www-form-urlencoded",
      Headers.acceptHeader: "application/json",
    });
  }

  static Future<bool> executeApiWithTryCatch(Function function) async {
    try {
      //Success Load API
      await function();
      return true;
    } on DioError catch (e) {
      //Failed Load API
      print(e.toString());
      return false;
    }
  }

  static Dio dio() {
    final options = BaseOptions(
        baseUrl: "$baseUrl/",
        contentType: "application/json",
        // connectTimeout: 30000,
        // sendTimeout: 30000,
        // receiveTimeout: 30000,
        responseType: ResponseType.json);

    var dio = Dio(options);

    return dio;
  }
}
