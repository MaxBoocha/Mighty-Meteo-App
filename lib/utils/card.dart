import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mightymeteomap/controller/location_controller.dart';

class MyCard extends StatelessWidget {
  MyCard({Key? key}) : super(key: key);
  final LocationController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Obx(() => Text("${c.getName()}")),
              Obx(() => Text("Temp : ${c.getTemp()}")),
              Obx(() => Text("TempMin : ${c.getTempMin()}")),
              Obx(() => Text("TempMax : ${c.getTempMax()}")),
              Obx(() => Text("Humidité : ${c.getHumi()}")),
              Obx(() => Icon(c.getIconData(), size: 24.0, color: Colors.black)),
              Obx(() => Text("Temps : ${c.getWeather()}"))
            ]));
  }
}
