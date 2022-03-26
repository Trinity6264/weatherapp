import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/shared/color_pallet.dart';
import 'package:weather/shared/text_decor.dart';
import 'package:weather/view_models/show_weather_view_model.dart';

class BottomSearch extends StatefulWidget {
  const BottomSearch({Key? key}) : super(key: key);

  @override
  State<BottomSearch> createState() => _BottomSearchState();
}

class _BottomSearchState extends State<BottomSearch> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightSeaBlueColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Center(
          child: TextField(
            decoration: textDecor.copyWith(
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<ShowWeatherViewModel>().weatherModel = null;
                  context
                      .read<ShowWeatherViewModel>()
                      .fecthingData(city: controller.text.trim());
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.search),
              ),
            ),
            controller: controller,
          ),
        ),
      ),
    );
  }
}
