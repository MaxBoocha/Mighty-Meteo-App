import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mightymeteomap/controller/user.dart';

// ignore: must_be_immutable
class TakePicture extends StatelessWidget {
  TakePicture({Key? key}) : super(key: key);

  final UserController c = Get.find();
  // ignore: prefer_typing_uninitialized_variables
  var _image;
  final imagePicker = ImagePicker();

  Future getImage() async {
    // ignore: deprecated_member_use
    final image = await imagePicker.getImage(source: ImageSource.camera);
    if (image != null) _image = File(image.path);
  }

  Future<String> uploadImage(File file) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.imgur.com/3/image"));

    request.fields['title'] = file.path;
    request.headers['Authorization'] = "Client-ID " "f87ae40c189b185";

    var picture = http.MultipartFile.fromBytes('image', file.readAsBytesSync(),
        filename: file.path);

    request.files.add(picture);

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    var json = convert.jsonDecode(result);
    return (json['data']['link']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _image == null
              ? const Center(child: Text("Take a picture"))
              : Image.file(_image),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              heroTag: "take a photo",
              onPressed: getImage,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.camera),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              heroTag: "use as profile pic ",
              onPressed: () async => {
                if (_image != null)
                  c.updatePictureUser(
                      urlPP: await uploadImage(_image),
                      user: await c.getCurrentUser())
              },
              child: const Icon(Icons.person),
            ),
          ),
        )
      ],
    ));
  }
}
