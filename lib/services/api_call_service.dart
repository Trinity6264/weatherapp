import 'dart:convert';

import 'package:weather/models/weather_model.dart';
import 'package:http/http.dart' as response;

const apiKey = '03da0e6feca1fa12625fef8722a57322';

/// making the class a singleton for not creating many instnace when i call it
class ApiService {
  ApiService._();
  static final instance = ApiService._();

  /// fecthing data from the api by passing the necessary String[value]
  Future<response.Response?> fecthData({required String city}) async {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';
    response.Response _data = await response.get(Uri.parse(url));
    return _data;
  }
}
