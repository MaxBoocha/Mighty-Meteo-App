import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdresseController extends GetxController {
  final RxString _postion = "Loading...".obs;
  change(value) => _postion.value = value;
  get() => _postion.value;
  final String _apiUrl = 'https://api-adresse.data.gouv.fr';

  @override
  void onInit() {
    super.onInit();
    _getLocation();
  }

  Future<Position> _determinePosition() async {
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
    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getData(Position postion) async {
    final http.Response response = await http.get(Uri.parse(
      '$_apiUrl/reverse/?lon=${postion.longitude}&lat=${postion.latitude}',
    ));
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return res['features'][0]['properties']['label'];
    }
    return 'An error occured ${response.statusCode}';
  }

  Future<void> _getLocation() async {
    final Position position = await _determinePosition();
    final String address = await _getData(position);
    change(address);
  }
}
