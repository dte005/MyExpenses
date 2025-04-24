import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myexpenses/components/transaction_form.dart';
import 'package:myexpenses/components/transaction_list.dart';
import 'package:myexpenses/models/Transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List<Transaction> _transactions = [];

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    //Fechando o modal
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoal"),
        //Adicionando no menu uma acao baseada na funcao passada e no icone que representa
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
          ),
        ],
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                color: Theme.of(context).colorScheme.secondary,
                elevation: 5,
                child: Text("Gráfico"),
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      //Aiciona um botato na parte de baixo da tela automaticamente
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      //Posiciona o botao aonde for necessario na tela
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
