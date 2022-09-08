import 'package:flutter/material.dart';
import '../shared/global.dart';

class MessageUtil {
  static showAlertOk(String message, {Function()? onOkPressed}) {
    return showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: const Text('Aviso', style: TextStyle(color: Colors.red)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                //mesmo cancelando a fim de nao ficar preso nessa tela estou repetindo a mesma acao
                Navigator.of(context).pop();
                if (onOkPressed != null) onOkPressed();
              },
            ),
            TextButton(
              child: const Text('Tentar novamente'),
              onPressed: () {
                Navigator.of(context).pop();
                if (onOkPressed != null) onOkPressed();
              },
            ),
          ],
        );
      },
    );
  }
}
