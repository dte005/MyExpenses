import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myexpenses/models/transaction.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      //Subtrai do dia atual o index par achar os proximos dias da semana
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;
        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }
      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    });
  }

  double get _weekTotalValue {
    var grouped = groupedTransactions.fold(0.0, (sum, tr) {
      return sum + double.parse(tr['value'].toString());
    });
    return grouped > 0.0 ? grouped : 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            groupedTransactions.map((tr) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: tr['day'].toString(),
                  value: double.parse(tr['value'].toString()),
                  percentage:
                      double.parse(tr['value'].toString()) / _weekTotalValue,
                ),
              );
            }).toList(),
      ),
    );
  }
}
