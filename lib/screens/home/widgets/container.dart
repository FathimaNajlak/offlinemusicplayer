import 'package:flutter/material.dart';

Widget buttonHome(BuildContext context, String labelText,
    Widget screenToNavigate, Color color) {
  return ElevatedButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screenToNavigate,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
      child: Text(
        labelText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
