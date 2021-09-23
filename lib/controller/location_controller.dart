import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mightymeteomap/utils/weather_icon_mapper.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  final RxDouble _temp = 0.0.obs;
  final RxDouble _tempMin = 0.0.obs;
  final RxDouble _tempMax = 0.0.obs;
  final RxInt _humi = 0.obs;
  final RxString _icon = "".obs;
  final RxString _weather = "".obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxString _name = "".obs;
  final RxString _searchTown = "".obs;
  final String _apiUrl = "http://api.openweathermap.org";
  final String _apiKey = "04861993e066f5b8aaffe6988957c264";

  changeTemp(value) => _temp.value = value - 273.15;
  changeTempMin(value) => _tempMin.value = value - 273.15;
  changeTempMax(value) => _tempMax.value = value - 273.15;
  changeHumi(value) => _humi.value = value;
  changeIcon(value) => _icon.value = value;
  changeWeather(value) => _weather.value = value;
  changeLatitude(value) => _latitude.value = value;
  changeLongitude(value) => _longitude.value = value;
  changeName(value) => _name.value = value;
  changeSearchTown(value) => _searchTown.value = value;
  getTemp() => double.parse(_temp.value.toString()).toStringAsFixed(1);
  getTempMin() => double.parse(_tempMin.value.toString()).toStringAsFixed(1);
  getTempMax() => double.parse(_tempMax.value.toString()).toStringAsFixed(1);
  getHumi() => _humi.value;
  getIcon() => _icon.value;
  getWeather() => _weather.value;
  getLatitude() => _latitude.value;
  getLongitude() => _longitude.value;
  getName() => _name.value;
  getSearchTown() => _searchTown.value;

  @override
  void onInit() async {
    await _determinePosition();
    await getWeatherDataFromLocation();
    //getWeatherDataFromCity("Marseille");
    super.onInit();
  }

  Future<void> getWeatherDataFromCity(String cityName) async {
    final url = '$_apiUrl/data/2.5/weather?q=$cityName&appid=$_apiKey';
    print(url);
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      changeTemp(res['main']['temp']);
      changeTempMin(res['main']['temp_min']);
      changeTempMax(res['main']['temp_max']);
      changeHumi(res['main']['humidity']);
      changeIcon(res['weather'][0]['icon']);
      changeWeather(res['weather'][0]['main']);
      changeName(res['name']);
    } else {
      print('An error occured ${response.statusCode}');
      // error
    }
  }

  Future<void> getWeatherDataFromLocation() async {
    final url =
        '$_apiUrl/data/2.5/weather?lat=$_latitude&lon=$_longitude&appid=$_apiKey';
    print('fetching $url');
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      //print(res);
      changeTemp(res['main']['temp']);
      changeTempMin(res['main']['temp_min']);
      changeTempMax(res['main']['temp_max']);
      changeHumi(res['main']['humidity']);
      changeIcon(res['weather'][0]['icon']);
      changeWeather(res['weather'][0]['main']);
      changeName(res['name']);
    } else {
      print('An error occured ${response.statusCode}');
      // error
    }
  }

  IconData getIconData() {
    switch (_icon.value) {
      case '01d':
        return WeatherIcons.clearDay;
      case '01n':
        return WeatherIcons.clearNight;
      case '02d':
        return WeatherIcons.fewCloudsDay;
      case '02n':
        return WeatherIcons.fewCloudsNight;
      case '03d':
      case '04d':
        return WeatherIcons.cloudsDay;
      case '03n':
      case '04n':
        return WeatherIcons.cloudsNight;
      case '09d':
        return WeatherIcons.showerRainDay;
      case '09n':
        return WeatherIcons.showerRainNight;
      case '10d':
        return WeatherIcons.rainDay;
      case '10n':
        return WeatherIcons.rainNight;
      case '11d':
        return WeatherIcons.thunderStormDay;
      case '11n':
        return WeatherIcons.thunderStormNight;
      case '13d':
        return WeatherIcons.snowDay;
      case '13n':
        return WeatherIcons.snowNight;
      case '50d':
        return WeatherIcons.mistDay;
      case '50n':
        return WeatherIcons.mistNight;
      default:
        return WeatherIcons.clearDay;
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    changeLatitude(position.latitude.toDouble());
    changeLongitude(position.longitude.toDouble());
  }
}
