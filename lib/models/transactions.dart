import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String dueDate;
  final String amount; //string to keep decimal precision
  final bool
      isIncluded; //to see whether to use in calculation of daily disbursement
  Transaction(
      {@required this.id,
      @required this.dueDate,
      @required this.amount,
      @required this.isIncluded});

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dueDate = json['dueDate'],
        amount = json['amount'],
        isIncluded = false;
}
