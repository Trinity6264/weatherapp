import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/routes/route_manager.dart';

import 'package:weather/shared/color_pallet.dart';
import 'package:weather/view_models/show_weather_view_model.dart';
import 'package:weather/views/bottom_search.dart';

class ShowWeatherView extends StatelessWidget {
  const ShowWeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _show(BuildContext ctx) {
      showModalBottomSheet(
        elevation: 10,
        isScrollControlled: true,
        enableDrag: true,
        backgroundColor: whiteColor,
        context: ctx,
        builder: (ctx) => const BottomSearch(),
      );
    }

    Size _size = MediaQuery.of(context).size;
    return Consumer<ShowWeatherViewModel>(
      builder: (context, value, child) {
        return value.weatherModel == null && value.isBusy == true
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : value.weatherModel == null && value.isBusy == false
                ? Scaffold(
                    backgroundColor: backGroundColor,
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            value.errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 30.0,
                            ),
                          ),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () => _show(context),
                            child: const Text('Try Again'),
                          )
                        ],
                      ),
                    ),
                  )
                : Scaffold(
                    backgroundColor: backGroundColor,
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 10),
                          Text(
                            '${value.weatherModel!.name}',
                            style: const TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        IconButton(
                          onPressed: () => _show(context),
                          icon: const Icon(Icons.search, color: Colors.white),
                        ),
                      ],
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 70, left: 40, right: 40),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  lightSeaBlueColor,
                                  seaBlueColor,
                                  seaBlueColor,
                                ],
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'http://openweathermap.org/img/wn/${value.weatherModel!.weather![0].icon!}@2x.png',
                                      useOldImageOnUrlChange: true,
                                      errorWidget: (context, url, error) {
                                        return const Icon(
                                          Icons.broken_image_rounded,
                                        );
                                      },
                                      placeholder: (context, index) {
                                        return const Icon(
                                          Icons.image,
                                          color: whiteColor,
                                          size: 60.0,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                      height: _size.height * 0.26,
                                      width: 180,
                                    ),
                                  ),
                                  Text(
                                    '${value.weatherModel!.main!.temp}°',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: whiteColor,
                                      fontSize: 100.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${value.weatherModel!.weather![0].description}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: whiteColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: const [
                                      Expanded(
                                        child: Divider(
                                            color: whiteColor, thickness: 0.5),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomInfoWidget(
                                        title: 'Humidity',
                                        value:
                                            '${value.weatherModel!.main!.humidity}%',
                                        icon: Icons.water_drop,
                                      ),
                                      CustomInfoWidget(
                                        title: 'Feels like',
                                        value:
                                            '${value.weatherModel!.main!.feelsLike}',
                                        icon: Icons.vape_free_outlined,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _size.height * 0.1,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  RouteManager.showDetailsPage,
                                ),
                                child: Container(
                                  width: 150,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'More Details',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: seaBlueColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.arrow_forward,
                                          color: seaBlueColor),
                                    ],
                                  ),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
      },
    );
  }
}

class CustomInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const CustomInfoWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: whiteColor.withOpacity(0.7)),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
