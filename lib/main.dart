import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) => BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                primarySwatch: getThemeColor(
                  BlocProvider.of<GetWeatherCubit>(context)
                      .weatherModel
                      ?.weatherCondition,
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: const HomeView(),
            );
          },
        ),
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }

  String normalizedCondition = condition.toLowerCase();

  if (normalizedCondition.contains('sunny')) {
    return Colors.orange;
  } else if (normalizedCondition.contains('clear')) {
    return Colors.blue;
  } else if (normalizedCondition.contains('cloudy')) {
    return Colors.grey;
  } else if (normalizedCondition.contains('overcast')) {
    return Colors.blueGrey;
  } else if (normalizedCondition.contains('rain')) {
    return Colors.blue;
  } else if (normalizedCondition.contains('snow')) {
    return Colors.lightBlue;
  } else if (normalizedCondition.contains('thunder')) {
    return Colors.deepPurple;
  } else if (normalizedCondition.contains('fog') ||
      normalizedCondition.contains('mist')) {
    return Colors.grey;
  } else if (normalizedCondition.contains('drizzle')) {
    return Colors.lightBlue;
  } else if (normalizedCondition.contains('sleet')) {
    return Colors.cyan;
  } else if (normalizedCondition.contains('blizzard')) {
    return Colors.blueGrey;
  } else if (normalizedCondition.contains('ice')) {
    return Colors.cyan;
  } else {
    // Default color if no match
    return Colors.blueGrey;
  }
}
