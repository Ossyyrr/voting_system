import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogPlatfom extends StatelessWidget {
  const DialogPlatfom({Key? key, required this.textController, required this.onPressed, required this.title})
      : super(key: key);
  final TextEditingController textController;
  final void Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: Text(title),
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
            title: Text(title),
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
    required String title,
  }) {
    return Platform.isAndroid
        ? showDialog(
            context: context,
            builder: (_) => DialogPlatfom(
              textController: textController,
              onPressed: onPressed,
              title: title,
            ),
          )
        : showCupertinoDialog(
            context: context,
            builder: (_) => DialogPlatfom(
              textController: textController,
              onPressed: onPressed,
              title: title,
            ),
          );
  }
}
