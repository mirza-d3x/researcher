// To parse this JSON data, do
//
//     final salesPageResponse = salesPageResponseFromJson(jsonString);

import 'dart:convert';

class SalesPageResponse {
  SalesPageResponse({
    required this.statusCode,
    required this.message,
    required this.data,
    required this.count,
  });

  final int statusCode;
  final String message;
  final List<Datum> data;
  final int count;

  factory SalesPageResponse.fromRawJson(String str) =>
      SalesPageResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesPageResponse.fromJson(Map<String, dynamic> json) =>
      SalesPageResponse(
        statusCode: json["StatusCode"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.salesOrderMasterId,
    required this.voucherNo,
    required this.date,
    required this.phone,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.ledgerId,
    required this.customerName,
    required this.area,
    required this.grandTotal,
    required this.status,
  });

  final String id;
  final int salesOrderMasterId;
  final String voucherNo;
  final DateTime date;
  final int phone;
  final DateTime deliveryDate;
  final String deliveryTime;
  final int ledgerId;
  final String customerName;
  final String area;
  final String grandTotal;
  final String status;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        salesOrderMasterId: json["SalesOrderMasterID"],
        voucherNo: json["VoucherNo"],
        date: DateTime.parse(json["Date"]),
        phone: json["Phone"],
        deliveryDate: DateTime.parse(json["DeliveryDate"]),
        deliveryTime: json["DeliveryTime"],
        ledgerId: json["LedgerID"],
        customerName: json["CustomerName"],
        area: json["Area"],
        grandTotal: json["GrandTotal"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "SalesOrderMasterID": salesOrderMasterId,
        "VoucherNo": voucherNo,
        "Date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "Phone": phone,
        "DeliveryDate":
            "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
        "DeliveryTime": deliveryTime,
        "LedgerID": ledgerId,
        "CustomerName": customerName,
        "Area": area,
        "GrandTotal": grandTotal,
        "Status": status,
      };
}
