import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Function(String title, double value) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionForm createState() => _TransactionForm();
}

class _TransactionForm extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  _onSubmit() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    //Recebe widget por heranca do state do component Statefull
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              //onSubmitted executa a submissao do formulario ao finalizar
              onSubmitted: (_) => _onSubmit(),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor R\$'),
              // numberWithOptions  => da a possibilidade tanto no android quanto IOS escolher casas decimais
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //onSubmitted executa a submissao do formulario ao finalizar
              onSubmitted: (_) => _onSubmit(),
              controller: valueController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text(
                    'Nova transação',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
