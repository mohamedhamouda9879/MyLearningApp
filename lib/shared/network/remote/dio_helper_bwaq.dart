import 'package:dio/dio.dart';
import 'package:my_learning_app/models/bwaq/notes_model.dart';

class DioHelperBwaq{

  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://noteapi.popssolutions.net/',
      receiveDataWhenStatusError: true,
    ));
  }
  static Future<Response> getNotesData(
  {
    required String Url,
}
      ) async {
    return await dio.get(
      Url,
    );
  }

  static Future<Response> postNote({
    required String Url,
    required Map<String,dynamic> data,
  }) async {

    return dio.post(Url, data: data);
  }
}
