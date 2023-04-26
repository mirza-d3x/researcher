import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:researcher/rz/Pagination/Api/Model/topuploginmodelclass.dart';
import 'package:researcher/rz/Pagination/Api/Model/pagination_model.dart';
import 'package:researcher/rz/Pagination/Api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiS {
  TopUpApiClient topUpApiClient = TopUpApiClient();
  Future<TopUpLoginModelClass> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final body = {
      "username": "Razeena",
      "password": "123456",
    };

    if (kDebugMode) {
      print("getlogin....");
    }
    Response response = await topUpApiClient.invokeAPI(
        path: "users/login", method: "LOGIN", body: body);
    log("_________________loginBody $body");
    prefs.setString('token', response.body);
    return TopUpLoginModelClass.fromJson(json.decode(response.body));
  }

  Future<SalesPageResponse> getSalesData(
      {required int pageNo, required int itemsPerPage}) async {
    Map body = {
      "search": "",
      "page_no": pageNo,
      "items_per_page": itemsPerPage,
    };
    Response response = await topUpApiClient.invokeAPI(
        path: 'sales/list-sale_order/', method: 'POST', body: body);

    return SalesPageResponse.fromJson(jsonDecode(response.body));
  }
}
