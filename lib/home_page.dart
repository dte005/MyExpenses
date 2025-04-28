import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myexpenses/components/transaction_form.dart';
import 'package:myexpenses/components/transaction_list.dart';
import 'package:myexpenses/models/transaction.dart';

import 'components/chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showGraphBar = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    //Fechando o modal
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          fontFamily: 'Miniver',
          fontSize: MediaQuery.of(context).textScaler.scale(30),
          fontWeight: FontWeight.bold,
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
      ),
      //Adicionando no menu uma acao baseada na funcao passada e no icone que representa
      actions: <Widget>[
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ),
        IconButton(onPressed: () => {}, icon: Icon(Icons.engineering)),
        if (_isLandScape)
          IconButton(
            onPressed:
                () => {
                  setState(() {
                    _showGraphBar = !_showGraphBar;
                  }),
                },
            icon: Icon(_showGraphBar ? Icons.list : Icons.pie_chart),
          ),
      ],
    );
    final availableHeight =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showGraphBar || !_isLandScape)
              Container(
                height: availableHeight * (_isLandScape ? 0.7 : 0.2),
                decoration: BoxDecoration(color: Colors.white),
                child: Chart(_recentTransactions),
              ),
            if (!_showGraphBar || !_isLandScape)
              Container(
                height: availableHeight * 0.8,
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
      //Aiciona um botato na parte de baixo da tela automaticamente
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        child: Icon(Icons.add),
      ),
      //Posiciona o botao aonde for necessario na tela
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
