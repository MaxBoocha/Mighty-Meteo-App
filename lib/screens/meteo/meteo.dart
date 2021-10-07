import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mightymeteomap/screens/meteo/location.dart';

// Page principale de la page Météo
class Meteo extends StatelessWidget {
  const Meteo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Météo"),
      ),
      resizeToAvoidBottomInset: false,
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
