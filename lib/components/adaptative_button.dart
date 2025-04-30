import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String? label;
  final void Function()? onPressed;

  AdaptativeButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoButton(
          onPressed: onPressed,
          child: Text(this.label!),
          color: Theme.of(context).primaryColor,
        )
        : ElevatedButton(
          onPressed: onPressed,
          child: Text(
            'Nova transação',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
