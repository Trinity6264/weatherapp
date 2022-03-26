import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/api_call_service.dart';

class ShowWeatherViewModel extends ChangeNotifier {
  // instance of the service class
  final _apiService = ApiService.instance;

  // creating a string var to store the error incase of any
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // this var checks if the api call is in progress
  //to display something to the user

  bool? isBusy;

  WeatherModel? weatherModel;

  /// listen to the data fecthing from service class
  Future<void>? fecthingData({required String city}) async {
    try {
      isBusy = true;
      final response = await _apiService
          .fecthData(city: city)
          .timeout(const Duration(seconds: 5), onTimeout: () {
        print('object');
        // isBusy = false;
        weatherModel = null;
        _errorMessage = "Can't find city weather data";
        return Response.bytes([], 400, persistentConnection: false);
      });

      if (response?.statusCode == 200) {
        final data = jsonDecode(response!.body);
        weatherModel = WeatherModel.fromJson(data);
        isBusy = false;
      } else {
        _errorMessage = "Can't find city weather data";
        isBusy = false;
        weatherModel = null;
      }
    } on Exception catch (e) {
      _errorMessage = e.toString();
      weatherModel = null;
    }
    notifyListeners();
  }
}
