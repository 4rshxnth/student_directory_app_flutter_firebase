import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> screen({
  required String name,
  required String phone,
  required String address,
  required BuildContext context,
}) async {
  try {
    await FirebaseFirestore.instance.collection('Data').add({
      "Name": name,
      "Phone": phone,
      "Address": address,
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Student data uploaded Successfully!")),
    );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Stream<QuerySnapshot> fetchdata() {
  return FirebaseFirestore.instance.collection('Data').snapshots();
}
