import 'package:flutter/material.dart';
import 'package:weather/views/wrapper_view.dart';

import '../views/show_details_view.dart';
import '../views/show_weather_view.dart';

class RouteManager {
  static const wrapperPage = '/';
  static const showWeatherPage = '/showWeather';
  static const showDetailsPage = '/details';

  static Route<dynamic> ongeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
       case wrapperPage:
        return MaterialPageRoute(
            builder: ((context) => const WrapperView()));
      case showWeatherPage:
        return MaterialPageRoute(
            builder: ((context) => const ShowWeatherView()));
      case showDetailsPage:
        return MaterialPageRoute(
            builder: ((context) => const ShowDetailsView()));
      default:
        throw const FormatException('Page not found');
    }
  }
}
