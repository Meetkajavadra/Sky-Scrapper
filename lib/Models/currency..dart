import 'dart:convert';

Currency ratesModelFromJson(String str) => Currency.fromJson(json.decode(str));

class Currency {
  Map<String, double> rates;

  Currency({
    required this.rates,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      rates: Map.from(json["rates"])
          .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    );
  }

  Map<String, dynamic> toJson() => {
    "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}