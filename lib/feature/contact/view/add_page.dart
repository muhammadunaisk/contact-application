import 'dart:io';
import 'package:contact_adding/feature/contact/controller/provider.dart';
import 'package:contact_adding/feature/contact/model/contactModel.dart';
import 'package:contact_adding/feature/contact/view/dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPage extends ConsumerWidget {
  final String? nameText;
  final String? phoneText;
  final bool isEdit;
  final int? index;
  AddPage({super.key, this.nameText, this.phoneText, this.isEdit = false, this.index});
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isEdit) {
      namecontroller.text = nameText ?? '';
      phonecontroller.text = phoneText ?? "";
    }

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(fontSize: 10, color: Colors.black),
          ),
        ),
        title: Text("Details"),
        centerTitle: true,
        actions: [
          TextButton.icon(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  ref.read(contactprovider.notifier).addContact(
                      index,
                      Contact(
                        imagefile: ref.watch(imageProvider) == null
                            ? null
                            : File(ref.watch(imageProvider)!.path),
                        name: namecontroller.text,
                        phone: phonecontroller.text,
                      ));
                  namecontroller.clear();
                  phonecontroller.clear();
                  ref.read(imageProvider.notifier).state = null;
                  Navigator.pop(context);
                }
              },
              icon: Icon(
                Icons.save,
                color: Colors.black,
              ),
              label: Text(
                "Save",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: Form(
        key: formkey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: ref.watch(imageProvider) == null
                        ? null
                        : FileImage(File(ref.watch(imageProvider)!.path)),
                    radius: 50,
                    backgroundColor: Colors.red,
                    child: IconButton(
                        onPressed: () {
                          showAlert(context);
                        },
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.white12,
                          size: 8 * 6,
                        )),
                  ),
                ],
              ),
              Text("Add photo"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "name cannot be empty";
                    }
                    return null;
                  },
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: " Name",
                      labelText: "Enter Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 13,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "number cannot be empty";
                    }
                    if (value.length < 10 || value.length > 13) {
                      return "enter a valid number";
                    }
                    return null;
                    
                  },
                  controller: phonecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: " Number",
                      labelText: "Enter Number"),
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
