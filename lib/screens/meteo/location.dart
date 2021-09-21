import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mightymeteomap/controller/location_controller.dart';
import 'package:mightymeteomap/utils/card.dart';

class MyCustomForm extends StatelessWidget {
  MyCustomForm({Key? key}) : super(key: key);

  final LocationController c = Get.find();
  final String townName = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            ElevatedButton(
              child: const Icon(Icons.search, size: 14),
              onPressed: () {
                c.getWeatherDataFromCity(c.getSearchTown());
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: (newText) {
                  c.changeSearchTown(newText);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nom de la ville',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Location extends StatelessWidget {
  Location({Key? key}) : super(key: key);

  final LocationController c = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyCustomForm(),
              MyCard(),
              ElevatedButton(
                child: const Icon(Icons.gps_fixed, size: 14),
                onPressed: () {
                  c.getWeatherDataFromLocation();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
              ),
            ]));
  }
}
