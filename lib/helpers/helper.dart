import 'package:http/http.dart' as http;

import '../Models/currency..dart';

class CurrencyAPIHelper {
  CurrencyAPIHelper._();

  static final CurrencyAPIHelper apiHelper = CurrencyAPIHelper._();

  Future<Currency?> fetchCurrencyData() async {
    var response = await http.get(
      Uri.parse(
          "https://openexchangerates.org/api/latest.json?base=USD&app_id=8494337db9d84b398dafc459d53103c7"),
    );
    final result = ratesModelFromJson(response.body);
    return result;
  }
}

String convertansy(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  String output = (double.parse(amount) /
      exchangeRates[currencybase] *
      exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();

  return output;
}