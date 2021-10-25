import 'package:flutter/material.dart';
import 'package:mightymeteomap/screens/wrapper.dart';
import 'package:get/get.dart';
import 'package:mightymeteomap/screens/profile/profile.dart';
import 'package:mightymeteomap/screens/meteo/meteo.dart';
import 'package:mightymeteomap/screens/authenticate/login.dart';
import 'package:mightymeteomap/screens/authenticate/register.dart';

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
        GetPage(name: "/profile", page: () => ProfilePage()),
        GetPage(name: "/meteo", page: () => const Meteo()),
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/register", page: () => Register()),
      ],
    );
  }
}
