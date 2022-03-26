import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/routes/route_manager.dart';
import 'package:weather/services/api_call_service.dart';
import 'package:weather/view_models/show_weather_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> ShowWeatherViewModel()),
      ],
      builder: (context,child)=> MaterialApp(
        title: 'Weather app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RouteManager.showWeatherPage,
        onGenerateRoute: RouteManager.ongeneratedRoutes,
      ),
    );
  }
}
