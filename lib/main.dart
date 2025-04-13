import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myexpenses/models/Transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo tenis de corrida',
      value: 310.75,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despensa Pessoal"),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Card(
              color: Colors.blue,
              child: Text("Gráfico"),
              elevation: 5,
            ),
          ),
          Column(
            children:
                _transactions.map((item) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'R\$ ${item.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('d MMM y').format(item.date),
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(decoration: InputDecoration(labelText: 'Título')),
                  TextField(
                    decoration: InputDecoration(labelText: 'Valor R\$'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Nova transação',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
