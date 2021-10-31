import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mighty Meteo App'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Login Page'),
                onPressed: () {
                  Get.toNamed("/login");
                },
              ),
              ElevatedButton(
                child: const Text('Meteo Page'),
                onPressed: () {
                  Get.toNamed("/meteo");
                },
              ),
            ],
          ),
        ));
  }
}
