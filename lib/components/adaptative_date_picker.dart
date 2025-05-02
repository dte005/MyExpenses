import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const AdaptativeDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((picked) {
      if (picked == null) return;
      onDateChanged(picked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? Container(
          height: 180,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(2019),
            maximumDate: DateTime.now(),
            onDateTimeChanged: onDateChanged,
          ),
        )
        : Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(DateFormat('dd/MM/yy').format(selectedDate)),
              IconButton(
                icon: const Icon(Icons.calendar_month),
                color: Theme.of(context).colorScheme.primary,
                tooltip: 'Seletione uma data',
                onPressed: () => _showDatePicker(context),
              ),
            ],
          ),
        ));
  }
}
