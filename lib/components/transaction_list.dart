import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  Widget handlerRenderNoTransaction(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.2,
                  child: Image.asset(
                    'assets/images/img.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Text(
                  "Nenhuma transação",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "Quicksand",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
          //usado para carregar o elemento conforme a lista vai sendo varrida pelo usuario
          // facilitando ao nao carregamento de itens desnecessarios na memoria do celular
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            final item = transactions[index];
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'R\$ ${item.value.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
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
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        MediaQuery.of(context).size.width > 480
                            ? TextButton.icon(
                              icon: Icon(Icons.delete),
                              onPressed: () => onRemove(item.id),
                              label: Text("Excluir"),
                            )
                            : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () => onRemove(item.id),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
        : handlerRenderNoTransaction(context);
  }
}
