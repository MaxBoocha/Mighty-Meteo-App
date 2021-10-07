import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mightymeteomap/controller/location_controller.dart';

// Card qui sers à afficher les informations de la météo du jour
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
              Obx(() => Text(
                    "${c.getName()}",
                    style: const TextStyle(fontSize: 20),
                  )),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding:
                              const EdgeInsets.only(right: 14.0, bottom: 11.0),
                          child: Icon(c.getIconData(0),
                              size: 35.0, color: Colors.black)),
                      Text("${c.getTemp(0)}°C",
                          style: const TextStyle(fontSize: 10))
                    ],
                  )),
              Obx(() => Text(
                  "Min : ${c.getTempMin(0)}°C Max : ${c.getTempMax(0)}°C",
                  style: const TextStyle(fontSize: 10))),
              Obx(() => Text("Humidité : ${c.getHumi(0)}%",
                  style: const TextStyle(fontSize: 10))),
            ]));
  }
}
