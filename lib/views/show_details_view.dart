import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather/shared/color_pallet.dart';
import 'package:weather/view_models/show_weather_view_model.dart';

class ShowDetailsView extends StatelessWidget {
  const ShowDetailsView({Key? key}) : super(key: key);

  DateTime toMilli(int value) {
    final _results = value * 1000;
    DateTime _sunrise = DateTime.fromMillisecondsSinceEpoch(_results);
    return _sunrise;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<ShowWeatherViewModel>(
        builder: ((context, value, child) {
          final model = value.weatherModel;
          final _data = value.weatherModel!.sys!.sunrise;
          final _data1 = value.weatherModel!.sys!.sunset;
          DateTime _sunrise = toMilli(_data!);
          DateTime _sunset = toMilli(_data1!);
          return Column(
            children: [
              SizedBox(
                height: _size.height * 0.2,
                child: const Center(
                  child: Text(
                    'More Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 60),
                  padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        lightSeaBlueColor,
                        seaBlueColor,
                        seaBlueColor,
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                      bottom: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DataWidget(
                        title: 'Sunrise',
                        data: _sunrise.toString().substring(11, 16),
                      ),
                      DataWidget(
                        title: 'Sunset',
                        data: _sunset.toString().substring(11, 16),
                      ),
                      DataWidget(
                        title: 'Wind speed',
                        data: model!.wind!.speed.toString() + ' km/h',
                      ),
                      DataWidget(
                        title: 'Pressure',
                        data: model.main!.pressure.toString() + ' mb',
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  final String title;
  final String data;
  const DataWidget({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            data,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 19.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
