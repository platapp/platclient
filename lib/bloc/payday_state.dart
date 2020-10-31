part of 'payday_bloc.dart';

@immutable
abstract class PaydayState {
  const PaydayState();
}

class PaydayInitial extends PaydayState {}

class PaydayLoadInProgress extends PaydayState {}

class PaydayLoadSuccess extends PaydayState {
  final double dailyDisbursement;

  const PaydayLoadSuccess({@required this.dailyDisbursement})
      : assert(dailyDisbursement != null);

  @override
  List<Object> get props => [dailyDisbursement];
}

class PaydayLoadFailure extends PaydayState {}
