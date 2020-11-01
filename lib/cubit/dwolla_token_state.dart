part of 'dwolla_token_cubit.dart';

@immutable
abstract class DwollaTokenState {}

class DwollaTokenInitial extends DwollaTokenState {}

class DwollaTokenValue extends DwollaTokenState {
  final String token;
  DwollaTokenValue({@required this.token});
}
