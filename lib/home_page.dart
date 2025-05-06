import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './components/transaction_form.dart';
import './components/transaction_list.dart';
import './models/transaction.dart';
import 'components/chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(onPressed: fn, icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.news : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.chart_pie : Icons.pie_chart;

    final List<Widget> actionsBar = [
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
      _getIconButton(Icons.engineering, () => {}),
      if (isLandScape)
        _getIconButton(
          _showGraphBar ? iconList : iconChart,
          () => setState(() => _showGraphBar = !_showGraphBar),
        ),
    ];

    final PreferredSizeWidget appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          fontFamily: 'Miniver',
          fontSize: MediaQuery.of(context).textScaler.scale(30),
          fontWeight: FontWeight.bold,
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
      ),
      actions: actionsBar,
    );

    final availableHeight =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showGraphBar || !isLandScape)
              Container(
                height: availableHeight * (isLandScape ? 0.7 : 0.2),
                decoration: BoxDecoration(color: Colors.white),
                child: Chart(_recentTransactions),
              ),
            if (!_showGraphBar || !isLandScape)
              Container(
                height: availableHeight * (isLandScape ? 1 : 0.8),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('Despesas Pessoais'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: actionsBar),
          ),
          child: bodyPage,
        )
        : Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar,
          body: bodyPage,
          //Aiciona um botato na parte de baixo da tela automaticamente
          floatingActionButton: FloatingActionButton(
            onPressed: () => _openTransactionFormModal(context),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
            child: const Icon(Icons.add),
          ),
          //Posiciona o botao aonde for necessario na tela
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
  }
}
