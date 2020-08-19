import 'dart:convert';

import 'package:covid_tracker/model/country.dart';
import 'package:http/http.dart' as http;
import 'countries.dart';

//countries Map'indeki tum ulkeleri cekecegis
List<String> getAllCountries() {
  List<String> allCountries = [];
  countries.forEach((key, value) => allCountries.add(value));
  return allCountries;
}

//Api'de veriler alpha2 koduna gore saklandigi icin paremetre ile gonderdigimiz ulke adini
//alpha2 kaduna cevirecegiz
String convertAlpa(var countryName) {
  for (var entry in countries.entries) {
    if (entry.value == countryName) {
      return entry.key;
    }
  }
}

Future<Country> fetchData(String countryName) async {
  String alphaCode = convertAlpa(countryName);

  var response = await http.get('https://corona-api.com/countries/' + alphaCode);
  if (response.statusCode == 200) {
      return Country.fromJson(countryName, json.decode(response.body));
    } else {
      throw Exception('Veri çekilemedi');
    }
}
