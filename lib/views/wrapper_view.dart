import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/view_models/show_weather_view_model.dart';
import 'package:weather/views/show_weather_view.dart';

class WrapperView extends StatelessWidget {
  const WrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ser = Provider.of<ShowWeatherViewModel>(context, listen: false);
    return FutureProvider.value(
      value: _ser.fecthingData(city: 'johannesburg'),
      initialData: '',
      builder: ((context, child) => const ShowWeatherView()),
    );
  }
}
