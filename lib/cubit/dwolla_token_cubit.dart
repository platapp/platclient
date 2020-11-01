import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dwolla_token_state.dart';

class DwollaTokenCubit extends Cubit<DwollaTokenState> {
  DwollaTokenCubit() : super(DwollaTokenInitial());
  void setToken(String token) => emit(DwollaTokenValue(token: token));
}
