import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_exception.dart';

class TopUpApiClient {
  static const String basePath = 'https://api.topupqatar.com/api/v1/';

  Future<Response> invokeAPI(
      {required String path,
      required String method,
      required Object? body}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(prefs.getString('token'));
    print("Invoke Api worked");
    print(method);

    Map<String, String> headerParams = {};
    if (method == 'POST' ||
        method == 'GET' ||
        method == 'PATCH' ||
        method == "DELETE") {
      final token = prefs.getString('token');
      print("Methode POST OR GET");
      headerParams = {
        "authorization": "Bearer $token",
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
    } else if (method == "DELETE_") {
      final token = prefs.getString('token');
      print("method Delete_");
      headerParams = {
        "authorization": "Bearer $token",
      };
    }
    Response response;

    String url = basePath + path;
    // String searchurl =  basePath + 'search/movie'+'?api_key=$token'+ path;
    print('========================================' + url);

    // print(searchurl);
    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;

    switch (method) {
      case "POST":
        response = await post(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "LOGIN":
        response =
            await post(Uri.parse(url), headers: headerParams, body: body);
        break;
      case "PUT":
        response = await put(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "PATCH":
        response = await patch(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "DELETE":
        response = await delete(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "DELETE_":
        response = await delete(Uri.parse(url),
            headers: headerParams, body: jsonEncode(body));
        break;
      case "POST_":
        response = await post(
          Uri.parse(url),
          headers: headerParams,
          body: body,
        );
        break;
      case "GET_":
        response = await post(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;

      default:
        response = await get(Uri.parse(url), headers: headerParams);
    }
    log("**************${response.body}");

    print('status of $path =>' + (response.statusCode).toString());
    print(response.body);
    if (response.statusCode >= 400) {
      // print("if)()");
      log(path +
          ' : ' +
          response.statusCode.toString() +
          ' : ' +
          response.body);

      throw ApiException(
          message: _decodeBodyBytes(response), statusCode: response.statusCode);
    }
    ;
    return response;
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}
