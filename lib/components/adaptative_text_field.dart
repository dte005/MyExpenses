import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './adaptative_style.dart';

class AdaptativeTextField extends StatelessWidget {
  final void Function()? onChange;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? label;
  final AdaptativeStyle? style;
  final double fixed = 10;

  AdaptativeTextField({
    this.label,
    this.keyboardType,
    this.onChange,
    this.controller,
    this.style,
  });

  AdaptativeStyle checkingStyle(AdaptativeStyle? style) {
    return style ?? AdaptativeStyle.position(10, 10, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: EdgeInsets.only(bottom: checkingStyle(style).margin ?? 10),
          child: CupertinoTextField(
            padding: EdgeInsets.all(checkingStyle(style).padding ?? 10),
            keyboardType: keyboardType,
            onSubmitted: (_) => onChange!(),
            controller: controller,
            placeholder: label,
          ),
        )
        : Padding(
          padding: EdgeInsets.only(bottom: checkingStyle(style).margin ?? 10),
          child: TextField(
            decoration: InputDecoration(labelText: label),
            keyboardType: keyboardType,
            //onSubmitted executa a submissao do formulario ao finalizar
            onSubmitted: (_) => onChange!(),
            controller: controller,
          ),
        );
  }
}
