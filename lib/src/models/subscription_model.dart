import 'dart:convert';

import 'package:app/src/models/orders_model.dart';

List<SubscriptionModel> subscriptionFromJson(String str) => List<SubscriptionModel>.from(json.decode(str).map((x) => SubscriptionModel.fromJson(x)));

String expireSubscriptionToJson(List<SubscriptionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionModel {
  SubscriptionModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.date,
    required this.paymentMethod,
    required this.orderTotal,
    required this.dates,
    required this.notes,
    required this.order,
  });

  int id;
  String orderNumber;
  String status;
  String date;
  String paymentMethod;
  String orderTotal;
  List<Date> dates;
  List<dynamic> notes;
  Order order;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    id: json["id"] == null ? null : json["id"],
    orderNumber: json["order_number"] == null ? null : json["order_number"],
    status: json["status"] == null ? null : json["status"],
    date: json["date"] == null ? null : json["date"],
    paymentMethod: json["payment_method"] == null ? null : json["payment_method"],
    orderTotal: json["order_total"] == null ? null : json["order_total"],
    dates: json["dates"] == null ? [] : List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
    notes: json["notes"] == null ? [] : List<dynamic>.from(json["notes"].map((x) => x)),
    order: json["order"] == null ? Order.fromJson({}) : Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "order_number": orderNumber == null ? null : orderNumber,
    "status": status == null ? null : status,
    "date": date == null ? null : date,
    "payment_method": paymentMethod == null ? null : paymentMethod,
    "order_total": orderTotal == null ? null : orderTotal,
    "dates": dates == null ? null : List<dynamic>.from(dates.map((x) => x.toJson())),
    "notes": notes == null ? null : List<dynamic>.from(notes.map((x) => x)),
    "order": order == null ? null : order.toJson(),
  };
}

class Date {
  Date({
    required this.title,
    required this.datetime,
    required this.date,
  });

  String title;
  String datetime;
  String date;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    title: json["title"] == null ? null : json["title"],
    datetime: json["datetime"] == null ? null : json["datetime"],
    date: json["date"] == null ? null : json["date"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "date": date == null ? null : date,
  };
}
