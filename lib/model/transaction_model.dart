import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionModel {
  final String title;
  final DateTime dateTime;
  final String status;
  final String amount;

  TransactionModel({
    required this.title,
    required this.dateTime,
    required this.status,
    required this.amount,
  });

  String get formattedDate {
    String day = DateFormat('d').format(dateTime);
    String monthYear = DateFormat('MMMM yyyy').format(dateTime);

    String suffix = "th";
    if (day.endsWith("1") && day != "11")
      suffix = "st";
    else if (day.endsWith("2") && day != "12")
      suffix = "nd";
    else if (day.endsWith("3") && day != "13")
      suffix = "rd";

    return "$day$suffix $monthYear";
  }

  String get formattedTime => DateFormat('HH:mm').format(dateTime);

  List<Color> get gradientColors {
    switch (title) {
      case "Wallet deposit":
        return [const Color(0xff00BC7D), const Color(0xff005639)];
      case "Referral":
        return [const Color(0xff933FFE), const Color(0xff4F1F8C)];
      case "Bonus":
        return [const Color(0xffFF9900), const Color(0xff995C00)];
      case "Wallet Withdraw":
        return [const Color(0xffFB2C36), const Color(0xff951A20)];
      default:
        return [Colors.black26, Colors.grey];
    }
  }
}
