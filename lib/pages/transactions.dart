import 'package:flutter/material.dart';
import 'package:plat/bloc/payday_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plat/bloc/transactions_bloc.dart';
import 'package:plat/services/transactions.dart';

class Transactions extends StatelessWidget {
  final TransactionsClient transactionsClient;

  Transactions({Key key, @required this.transactionsClient})
      : assert(transactionsClient != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransactionsBloc(transactionsClient: transactionsClient),
      child: TransactionsPage(),
    );
  }
}

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Center(
        child: BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (context, state) {
            if (state is TransactionsInitial) {
              return Center(
                  child: Text('I need to fix this to load automatically'));
            }
            if (state is TransactionsLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is TransactionsLoadSuccess) {
              final transactions = state.transactions;
              return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'ID',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Amount',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Due Date',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: transactions.map((transaction) {
                    return DataRow(
                        onSelectChanged: (_) =>
                            BlocProvider.of<TransactionsBloc>(context).add(
                                TransactionsEventToggle(id: transaction.id)),
                        selected: transaction.isIncluded,
                        cells: <DataCell>[
                          DataCell(Text(transaction.id)),
                          DataCell(Text(transaction.amount)),
                          DataCell(Text(transaction.dueDate)),
                          //DataCell(Text(transaction.isIncluded)),
                        ]);
                  }).toList());
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
              onPressed: () => BlocProvider.of<TransactionsBloc>(context)
                  .add(TransactionsEventLastSaved(id: 'someid'))),
          const SizedBox(height: 8),
          FloatingActionButton(
              key: const Key('counterView_decrement_floatingActionButton'),
              child: const Icon(Icons.remove),
              onPressed: () => BlocProvider.of<TransactionsBloc>(context)
                  .add(TransactionsEventNewCandidates(id: 'someid'))),
        ],
      ),
      //bottomNavigationBar: BottomNavPage(),
    );
  }
}
