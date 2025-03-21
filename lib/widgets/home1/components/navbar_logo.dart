import 'package:flutter/material.dart';

Widget buildLogo() {
  return Row(
    children: [
      Image.asset('images/greenlogo.png', height: 30, fit: BoxFit.contain),
      SizedBox(width: 10),
      Text(
        "GreenStride",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
