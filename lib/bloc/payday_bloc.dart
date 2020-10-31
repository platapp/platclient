import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plat/services/payday.dart';
part 'payday_event.dart';
part 'payday_state.dart';

class PaydayBloc extends Bloc<PaydayEvent, PaydayState> {
  final PaydayClient paydayClient;
  PaydayBloc({@required this.paydayClient}) : super(PaydayInitial());

  @override
  Stream<PaydayState> mapEventToState(
    PaydayEvent event,
  ) async* {
    if (event is PaydayMemoizeRequested) {
      yield PaydayLoadInProgress();
      try {
        final dailyDisbursement =
            await paydayClient.getMemoizedPayday(event.id);
        yield PaydayLoadSuccess(dailyDisbursement: dailyDisbursement);
      } catch (_) {
        yield PaydayLoadFailure();
      }
    }
    if (event is PaydayComputeRequested) {
      yield PaydayLoadInProgress();
      try {
        final dailyDisbursement =
            await paydayClient.getRecomputePayday(event.id);
        yield PaydayLoadSuccess(dailyDisbursement: dailyDisbursement);
      } catch (_) {
        yield PaydayLoadFailure();
      }
    }
  }
}
