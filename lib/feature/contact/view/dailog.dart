
import 'package:contact_adding/feature/contact/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

showAlert(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Center(
        child: Text(
      "Choose picture",
      style: TextStyle(fontSize: 20),
    )),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer(builder: (context, ref, child) {
            return TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                label: Text(
                  "camera",
                  style: TextStyle(color: Colors.black),
                ));
          }),
          Consumer(builder: (context, ref, child) {
            return TextButton.icon(
                onPressed: () async {
                  final imagePicker = ImagePicker();
                  XFile? image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    Navigator.pop(context);
                  }
                  ref.read(imageProvider.notifier).state = image;
                },
                icon: Icon(
                  Icons.photo_library_outlined,
                   color: Colors.black,
                ),
                label: Text("Gallery", style: TextStyle(color: Colors.black)));
          }),
        ],
      )
    ],
  );

  showDialog(
    context: context,
    builder: (context) {
      return alert;
    },
  );
}
