import 'package:flutter/material.dart';

import './adaptative_button.dart';
import './adaptative_date_picker.dart';
import './adaptative_style.dart';
import './adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) onSubmit;
  const TransactionForm(this.onSubmit, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionForm createState() => _TransactionForm();
}

class _TransactionForm extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _onSubmit() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    //Recebe widget por heranca do state do component Statefull
    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                label: "Título",
                onChange: _onSubmit,
                controller: titleController,
                style: AdaptativeStyle(padding: 20, margin: 20),
              ),
              AdaptativeTextField(
                label: "Valor R\$",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChange: _onSubmit,
                controller: valueController,
                style: AdaptativeStyle(padding: 20, margin: 20),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Nova transação',
                    onPressed: _onSubmit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
