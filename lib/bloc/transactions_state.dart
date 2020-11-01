part of 'transactions_bloc.dart';

@immutable
abstract class TransactionsState {
  const TransactionsState();
}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoadInProgress extends TransactionsState {}

class TransactionsLoadSuccess extends TransactionsState {
  final List<Transaction> transactions;

  const TransactionsLoadSuccess({@required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionsLoadFailure extends TransactionsState {
  final String message;
  const TransactionsLoadFailure({@required this.message});
}
