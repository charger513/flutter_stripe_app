import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Platform.isAndroid
        ? const AlertDialog(
            title: Text('Espere...'),
            content: LinearProgressIndicator(),
          )
        : const CupertinoAlertDialog(
            title: Text('Espere...'),
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: LinearProgressIndicator(),
            ),
          ),
  );
}

mostrarAlerta(BuildContext context, String titulo, String mensaje) {
  showDialog(
    context: context,
    builder: (_) => Platform.isAndroid
        ? AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: [
              MaterialButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: [
              MaterialButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
  );
}
