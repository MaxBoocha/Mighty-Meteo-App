import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Row(
        children: [
          ElevatedButton(
            child: const Text('Profile Page'),
            onPressed: () {
              Get.toNamed("/profile");
            },
          ),
          ElevatedButton(
            child: const Text('Meteo Page'),
            onPressed: () {
              Get.toNamed("/meteo");
            },
          )
        ],
      ),
    );
  }
}
