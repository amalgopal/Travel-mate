import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/custom_widge/expense_dialog.dart';
import 'package:travel_mate/db/functions/db_function.dart';

import '../model/trip_model.dart';

class ExpenseTab extends StatefulWidget {
  final TripModal trip;
  const ExpenseTab({super.key, required this.trip});

  @override
  State<ExpenseTab> createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
        body: FutureBuilder(
            future: getExpenses(widget.trip.id!),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListTile(
                        title: Text('${data[index]['spende']}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Text('₹ ${data[index]['amount']}'.toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('You Have no Expenses'));
              }
            }),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: ElevatedButton.icon(
            onPressed: () async {
              final data = await showDialog(
                  context: context,
                  builder: (context) => expenseDialog(
                        context,
                        widget.trip,
                      ));
              if (data == true) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Expense'),
          ),
        ));
  }
}
