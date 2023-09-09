//Snack Bar

import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 10000),
      content: Text(content),
    ),
  );
}
