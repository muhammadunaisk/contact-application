import 'package:flutter/material.dart';

showAlertedit(BuildContext context) {
  AlertDialog eidt = AlertDialog(
    title: Center(
      child: Text("Update Contact"),
    ),
    actions: [
      Column(
        children: [
          TextField(
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
        ],
      )
    ],
  );
  showDialog(
      context: context,
      builder: (context) {
        return eidt;
      });
}
