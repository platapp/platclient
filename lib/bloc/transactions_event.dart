part of 'transactions_bloc.dart';

@immutable
abstract class TransactionsEvent {
  const TransactionsEvent();
}

class TransactionsEventLastSaved extends TransactionsEvent {
  final String id;
  TransactionsEventLastSaved({@required this.id});
}

//retrieves potential new recurrent payments
class TransactionsEventNewCandidates extends TransactionsEvent {
  final String id;
  TransactionsEventNewCandidates({@required this.id});
}

//the payments class has the actual requirements (eg account#, etc)
class TransactionsEventAddManual extends TransactionsEvent {
  final Transaction transaction;
  TransactionsEventAddManual({@required this.transaction});
}

class TransactionsEventToggle extends TransactionsEvent {
  final String id;
  TransactionsEventToggle({@required this.id});
}

class TransactionsEventRemoveManual extends TransactionsEvent {
  final Transaction transaction;
  TransactionsEventRemoveManual({@required this.transaction});
}
