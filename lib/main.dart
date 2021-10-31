import 'package:flutter/material.dart';
import 'package:mightymeteomap/screens/takepicture/takepicture.dart';
import 'package:mightymeteomap/screens/wrapper.dart';
import 'package:get/get.dart';
import 'package:mightymeteomap/screens/profile/profile.dart';
import 'package:mightymeteomap/screens/meteo/meteo.dart';
import 'package:mightymeteomap/screens/authenticate/login.dart';
import 'package:mightymeteomap/screens/authenticate/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Mighty Meteo App",
      home: const Wrapper(),
      getPages: [
        GetPage(name: "/profile", page: () => ProfilePage()),
        GetPage(name: "/meteo", page: () => const Meteo()),
        GetPage(name: "/takepicture", page: () => TakePicture()), // to change
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/register", page: () => Register()),
      ],
    );
  }
}
