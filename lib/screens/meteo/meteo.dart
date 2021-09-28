import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mightymeteomap/screens/meteo/location.dart';

class Meteo extends StatelessWidget {
  const Meteo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Météo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Location(),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Go back!'),
          ),
        ],
      ),
    );
  }
}
