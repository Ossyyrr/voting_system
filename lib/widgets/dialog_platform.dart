import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogPlatfom extends StatelessWidget {
  const DialogPlatfom({Key? key, required this.textController, required this.onPressed}) : super(key: key);
  final TextEditingController textController;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: const Text('Nueva votación'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                onPressed: onPressed,
                child: const Text('add'),
                textColor: Colors.blue,
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: const Text('Nueva votación'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: onPressed,
                isDefaultAction: true,
                child: const Text('add'),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                isDestructiveAction: true,
                child: const Text('dismiss'),
              ),
            ],
          );
  }

  static showDialogPlatform({
    required BuildContext context,
    required TextEditingController textController,
    required void Function()? onPressed,
  }) {
    return Platform.isAndroid
        ? showDialog(
            context: context,
            builder: (_) => DialogPlatfom(textController: textController, onPressed: onPressed),
          )
        : showCupertinoDialog(
            context: context,
            builder: (_) => DialogPlatfom(textController: textController, onPressed: onPressed),
          );
  }
}
