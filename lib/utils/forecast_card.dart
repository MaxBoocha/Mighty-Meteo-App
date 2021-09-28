import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mightymeteomap/controller/location_controller.dart';

class MyForecastCard extends StatelessWidget {
  final int day;
  MyForecastCard({Key? key, this.day = 0}) : super(key: key);
  final LocationController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("N+$day"),
              Obx(() => Text(
                    "${c.getName()}",
                  )),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding:
                              const EdgeInsets.only(right: 15.0, bottom: 6.5),
                          child: Icon(c.getIconData(day), color: Colors.black)),
                      Text("${c.getTemp(day)}°C")
                    ],
                  )),
              Obx(() => Text(
                    "Min : ${c.getTempMin(day)}°C Max : ${c.getTempMax(day)}°C",
                  )),
              Obx(() => Text(
                    "Humidité : ${c.getHumi(day)}%",
                  )),
            ]));
  }
}
