import 'package:flutter/material.dart';

Future<bool> showErrorDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (builder) {
      return AlertDialog(
        title: const Text('An error occured'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
