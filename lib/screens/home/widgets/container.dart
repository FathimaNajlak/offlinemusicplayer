import 'package:flutter/material.dart';

Container containerHome(
  BuildContext context,
  String labelText,
  Widget screenToNavigate,
) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => screenToNavigate,
              ),
            ),
            child: Image.asset(
              'assets/images/dummy image.jpg',
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
