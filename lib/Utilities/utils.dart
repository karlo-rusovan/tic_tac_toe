import 'package:flutter/material.dart';

class Utils {
  static showSnackBar({required String? text, required BuildContext context}) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Row(children: [
              const Icon(Icons.warning, color: Color.fromARGB(250, 119, 7, 7), size: 20),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                text,                
                maxLines: 2,
              )),
            ]),          
      backgroundColor: const Color.fromARGB(0, 49, 47, 47),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 60, left: 20, right: 20),
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(milliseconds: 1800),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
