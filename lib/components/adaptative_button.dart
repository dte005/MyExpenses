import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String? label;
  final void Function()? onPressed;

  const AdaptativeButton({super.key, this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoButton(
          onPressed: onPressed,
          sizeStyle: CupertinoButtonSize.small,
          color: Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(5),
          focusColor: Theme.of(context).primaryColor,
          child: Text(label!, style: const TextStyle(color: Colors.white)),
        )
        : ElevatedButton(
          onPressed: onPressed,
          child: Text(
            label!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
