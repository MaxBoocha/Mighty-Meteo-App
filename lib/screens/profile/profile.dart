import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mightymeteomap/controller/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final UserController c = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'Name: ${c.getName()}',
                  style: Theme.of(context).textTheme.bodyText1,
                )),
            const SizedBox(height: 16.0),
            Obx(() => Text(
                  'Email: ${c.getEmail()}',
                  style: Theme.of(context).textTheme.bodyText1,
                )),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            c.getSignInOut()
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      c.changeSignInOut(true);
                      await FirebaseAuth.instance.signOut();
                      c.changeSignInOut(false);
                      Get.toNamed("/login");
                    },
                    child: const Text('Sign out'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
