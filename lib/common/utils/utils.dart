//Snack Bar

import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 100),
      content: Text(content),
    ),
  );
}
