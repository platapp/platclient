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
      if (state is TransactionsLoadSuccess) {
        yield* _mapAppendCandidateToState(
            event, (state as TransactionsLoadSuccess).transactions);
      } else {
        yield* _mapCandidateToState(event);
      }
    }
    if (event is TransactionsEventLastSaved) {
      yield* _mapSavedToState(event);
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
        yield* _mapToggleToState(
            event, (state as TransactionsLoadSuccess).transactions);
      } else {
        yield TransactionsLoadFailure(message: "No existing transactions");
      }
    }
  }

  Stream<TransactionsState> _mapAppendCandidateToState(
      TransactionsEventNewCandidates event,
      List<Transaction> currentTransactions) async* {
    yield TransactionsLoadInProgress();
    try {
      List<Transaction> transactions =
          await transactionsClient.getNewCandidateTransactions(event.id);

      final List<Transaction> updatedTransactions = currentTransactions
        ..addAll(transactions);
      yield TransactionsLoadSuccess(transactions: updatedTransactions);
    } catch (e) {
      yield TransactionsLoadFailure(message: e.toString());
    }
  }

  Stream<TransactionsState> _mapCandidateToState(
    TransactionsEventNewCandidates event,
  ) async* {
    yield TransactionsLoadInProgress();
    try {
      List<Transaction> transactions =
          await transactionsClient.getNewCandidateTransactions(event.id);
      yield TransactionsLoadSuccess(transactions: transactions);
    } catch (e) {
      yield TransactionsLoadFailure(message: e.toString());
    }
  }

  Stream<TransactionsState> _mapSavedToState(
      TransactionsEventLastSaved event) async* {
    yield TransactionsLoadInProgress();
    try {
      List<Transaction> transactions =
          (await transactionsClient.getLastSavedTransactions(event.id)).map((transaction) {
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

  Stream<TransactionsState> _mapToggleToState(TransactionsEventToggle event,
      List<Transaction> currentTransactions) async* {
    final List<Transaction> updatedTransactions =
        currentTransactions.map((transaction) {
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
  }
}
