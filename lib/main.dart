import 'package:flutter/material.dart';
import 'package:mightymeteomap/screens/wrapper.dart';
import 'package:get/get.dart';
import 'package:mightymeteomap/screens/profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Test",
      home: const Wrapper(),
      getPages: [
        GetPage(name: "/profile", page: () => const Profile()),
      ],
    );
  }
}
