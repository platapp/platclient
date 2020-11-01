import 'dart:js' as js;

class Plaid {
  open(String token) {
    //context.bloc<DwollaTokenCubit>().setToken
    js.context.callMethod('plaidLink', [token]).open();
  }
}
