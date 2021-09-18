import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mightymeteomap/controller/adresse.dart';

class Location extends StatelessWidget {
  Location({Key? key}) : super(key: key);

  final AdresseController c = Get.put(AdresseController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Text("${c.get()}")));
  }
}
