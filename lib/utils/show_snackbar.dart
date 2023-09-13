import 'package:flutter/material.dart';

showSnack(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor:
          title.contains("success") || title.contains("successfully")
              ? Colors.green
              : null,
      content: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
