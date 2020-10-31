import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:plat/services/payday.dart';
import 'package:plat/simple_bloc_observer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:plat/pages/payday.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final PaydayClient payDay = PaydayClient(httpClient: http.Client());
  runApp(MaterialApp(
      home: Payday(
    paydayClient: payDay,
  )));
}
