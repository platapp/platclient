part of 'payday_bloc.dart';

@immutable
abstract class PaydayEvent {
  const PaydayEvent();
}

class PaydayMemoizeRequested extends PaydayEvent {
  final String id;
  const PaydayMemoizeRequested({@required this.id});
  @override
  List<Object> get props => [id];
}

class PaydayComputeRequested extends PaydayEvent {
  final String id;
  const PaydayComputeRequested({@required this.id});
  @override
  List<Object> get props => [id];
}
