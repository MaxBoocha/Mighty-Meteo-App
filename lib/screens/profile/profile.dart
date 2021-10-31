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
            Container(
                alignment: Alignment.center, // use aligment
                child: Obx(() => Image.network(c.getPhotoUrl(),
                    height: 350, width: 400, fit: BoxFit.cover))),
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
            Obx(() => c.getVerified()
                ? Text(
                    'Email verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.green),
                  )
                : Text(
                    'Email not verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.red),
                  )),
            const SizedBox(height: 16.0),
            c.getSending()
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          c.changeSending(true);
                          await c.getCurrentUser().sendEmailVerification();
                          c.changeSending(false);
                        },
                        child: const Text('Verify email'),
                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () async {
                          User? user = await c.refreshUser(c.getCurrentUser());
                          if (user != null) {
                            c.changeCurrentUser(user);
                          }
                        },
                      ),
                    ],
                  ),
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
            ElevatedButton(
              child: const Text('Take a Picture'),
              onPressed: () {
                Get.toNamed("/takepicture");
              },
            )
          ],
        ),
      ),
    );
  }
}
