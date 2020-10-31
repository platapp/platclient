import 'package:flutter/material.dart';
import 'package:plat/bloc/payday_bloc.dart';
import 'package:plat/services/payday.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Payday extends StatelessWidget {
  final PaydayClient paydayClient;

  Payday({Key key, @required this.paydayClient})
      : assert(paydayClient != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaydayBloc(paydayClient: paydayClient),
      child: PaydayPage(),
    );
  }
}

class PaydayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payday')),
      body: Center(
        child: BlocBuilder<PaydayBloc, PaydayState>(
          builder: (context, state) {
            if (state is PaydayInitial) {
              return Center(child: Text('Please Select a Location'));
            }
            if (state is PaydayLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PaydayLoadSuccess) {
              final dailyDisbursement = state.dailyDisbursement;
              return Text('$dailyDisbursement');
            }
            if (state is PaydayLoadFailure) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              key: const Key('counterView_increment_floatingActionButton'),
              child: const Icon(Icons.add),
              onPressed: () => BlocProvider.of<PaydayBloc>(context)
                  .add(PaydayMemoizeRequested(id: 'someid'))),
          const SizedBox(height: 8),
          FloatingActionButton(
              key: const Key('counterView_decrement_floatingActionButton'),
              child: const Icon(Icons.remove),
              onPressed: () => BlocProvider.of<PaydayBloc>(context)
                  .add(PaydayComputeRequested(id: 'someid'))),
        ],
      ),
      //bottomNavigationBar: BottomNavPage(),
    );
  }
}
