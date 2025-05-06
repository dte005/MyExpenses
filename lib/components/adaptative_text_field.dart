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
  final AdaptativeStyle fixedStyle = AdaptativeStyle(padding: 10, margin: 10);

  AdaptativeTextField({
    super.key,
    this.label,
    this.keyboardType,
    this.onChange,
    this.controller,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: EdgeInsets.only(
            bottom:
                AdaptativeStyle.checkingStyle(style, fixedStyle).margin ??
                fixed,
          ),
          child: CupertinoTextField(
            padding: EdgeInsets.all(
              AdaptativeStyle.checkingStyle(style, fixedStyle).padding ?? fixed,
            ),
            keyboardType: keyboardType,
            onSubmitted: (_) => onChange!(),
            controller: controller,
            placeholder: label,
          ),
        )
        : Padding(
          padding: EdgeInsets.only(
            bottom:
                AdaptativeStyle.checkingStyle(style, fixedStyle).margin ??
                fixed,
          ),
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
