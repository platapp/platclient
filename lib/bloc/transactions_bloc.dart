import 'dart:async';
import 'package:plat/models/transactions.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plat/services/transactions.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionsClient transactionsClient;
  TransactionsBloc({@required this.transactionsClient})
      : super(TransactionsInitial());

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {
    if (event is TransactionsEventNewCandidates) {
      yield TransactionsLoadInProgress();
      try {
        List<Transaction> transactions =
            await transactionsClient.getNewCandidateTransactions(event.id);
        if (state is TransactionsLoadSuccess) {
          final List<Transaction> updatedTransactions =
              List.from((state as TransactionsLoadSuccess).transactions)
                ..addAll(transactions);
          yield TransactionsLoadSuccess(transactions: updatedTransactions);
        } else {
          yield TransactionsLoadSuccess(transactions: transactions);
        }
      } catch (e) {
        yield TransactionsLoadFailure(message: e.toString());
      }
    }
    if (event is TransactionsEventLastSaved) {
      yield TransactionsLoadInProgress();
      try {
        final transactions =
            (await transactionsClient.getLastSavedTransactions(event.id))
                .map((transaction) {
          return Transaction(
              id: transaction.id,
              dueDate: transaction.dueDate,
              amount: transaction.amount,
              isIncluded: true);
        }).toList();
        yield TransactionsLoadSuccess(transactions: transactions);
      } catch (e) {
        yield TransactionsLoadFailure(message: e.toString());
      }
    }
    if (event is TransactionsEventAddManual) {
      if (state is TransactionsLoadSuccess) {
        final List<Transaction> updatedTransactions =
            List.from((state as TransactionsLoadSuccess).transactions)
              ..add(event.transaction);
        yield TransactionsLoadSuccess(transactions: updatedTransactions);
      } else {
        yield TransactionsLoadSuccess(transactions: [event.transaction]);
      }
    }
    if (event is TransactionsEventRemoveManual) {
      //this will rarely be used
      if (state is TransactionsLoadSuccess) {
        final List<Transaction> updatedTransactions =
            (state as TransactionsLoadSuccess)
                .transactions
                .where((transaction) {
          return transaction.id != event.transaction.id;
        }).toList();
        yield TransactionsLoadSuccess(transactions: updatedTransactions);
      } else {
        yield TransactionsLoadFailure(message: "No existing transactions");
      }
    }
    if (event is TransactionsEventToggle) {
      if (state is TransactionsLoadSuccess) {
        final List<Transaction> updatedTransactions =
            (state as TransactionsLoadSuccess).transactions.map((transaction) {
          if (transaction.id == event.id) {
            return Transaction(
                id: transaction.id,
                amount: transaction.amount,
                dueDate: transaction.dueDate,
                isIncluded: !transaction.isIncluded);
          } else {
            return transaction;
          }
        }).toList();
        yield TransactionsLoadSuccess(transactions: updatedTransactions);
      } else {
        yield TransactionsLoadFailure(message: "No existing transactions");
      }
    }
  }
}
