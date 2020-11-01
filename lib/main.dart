import 'package:bloc/bloc.dart';
import 'package:plat/services/payday.dart';
import 'package:plat/simple_bloc_observer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:plat/pages/payday.dart';
import 'package:plat/pages/transactions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plat/bottom_nav/bottom_nav.dart';
import 'package:plat/bottom_nav/view/bottom_nav_view.dart';
import 'package:plat/services/transactions.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final PaydayClient payDay = PaydayClient(httpClient: http.Client());
  final TransactionsClient transactionsClient =
      TransactionsClient(httpClient: http.Client());
  runApp(MaterialApp(
      home: BlocProvider(
          create: (_) => BottomNavCubit(),
          child: Scaffold(
              body: BlocBuilder<BottomNavCubit, int>(builder: (context, state) {
                print(state);
                if (state == 0) {
                  return Payday(paydayClient: payDay);
                }
                if (state == 1) {
                  return Transactions(transactionsClient: transactionsClient);
                }
              }),
              bottomNavigationBar: BottomNavView()))));
}
