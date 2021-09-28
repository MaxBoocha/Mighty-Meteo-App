import 'package:flutter/material.dart';

/// Exposes specific weather icons
/// Has all weather conditions specified by open weather maps API
/// https://openweathermap.org/weather-conditions
// hex values and ttf file from https://erikflowers.github.io/weather-icons/
class WeatherIcons {
  static const IconData clearDay = IconData(0xf00d, fontFamily: 'WeatherIcons');
  static const IconData clearNight =
      IconData(0xf02e, fontFamily: 'WeatherIcons');

  static const IconData fewCloudsDay =
      IconData(0xf002, fontFamily: 'WeatherIcons');
  static const IconData fewCloudsNight =
      IconData(0xf081, fontFamily: 'WeatherIcons');

  static const IconData cloudsDay =
      IconData(0xf07d, fontFamily: 'WeatherIcons');
  static const IconData cloudsNight =
      IconData(0xf080, fontFamily: 'WeatherIcons');

  static const IconData showerRainDay =
      IconData(0xf009, fontFamily: 'WeatherIcons');
  static const IconData showerRainNight =
      IconData(0xf029, fontFamily: 'WeatherIcons');

  static const IconData rainDay = IconData(0xf008, fontFamily: 'WeatherIcons');
  static const IconData rainNight =
      IconData(0xf028, fontFamily: 'WeatherIcons');

  static const IconData thunderStormDay =
      IconData(0xf010, fontFamily: 'WeatherIcons');
  static const IconData thunderStormNight =
      IconData(0xf03b, fontFamily: 'WeatherIcons');

  static const IconData snowDay = IconData(0xf00a, fontFamily: 'WeatherIcons');
  static const IconData snowNight =
      IconData(0xf02a, fontFamily: 'WeatherIcons');

  static const IconData mistDay = IconData(0xf003, fontFamily: 'WeatherIcons');
  static const IconData mistNight =
      IconData(0xf04a, fontFamily: 'WeatherIcons');
}
