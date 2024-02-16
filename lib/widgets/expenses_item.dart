import 'package:expensize/screens/edit_screen.dart';
import 'package:flutter/material.dart';

import 'package:expensize/models/expenses.dart';
import 'package:hive/hive.dart';

class ExpenseItem extends StatefulWidget {
  ExpenseItem({
    this.deletFun,
    this.redEdit,
    this.expensesList,
    super.key,
  });

  Function? redEdit;
  Function? deletFun;

  List<Expenses>? expensesList;

  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  final _dbBox = Hive.box('expensizeDB');
  void onPress({index}) {
    showModalBottomSheet(
        context: context,
        builder: (context) => EditScreen(
              editData: () {
                widget.redEdit!();
              },
              resAmount: widget.expensesList![index].amount,
              resTitle: widget.expensesList![index].title,
              resCategory: widget.expensesList![index].category,
              resDate: widget.expensesList![index].date,
              itemIndex: index,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.expensesList?.length ?? 0,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(widget.expensesList![index].toString()),
            background: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Colors.red,
                child: Icon(Icons.delete),
              ),
            ),
            onDismissed: (u) {
              _dbBox.delete(index);
              widget.deletFun!();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  onPress(index: index);
                  print('_ExpenseItemState Type ${index.runtimeType}');
                },
                child: Card(
                  child: ListTile(
                    trailing: Column(
                      children: [
                        Expanded(
                          child: Text(
                            widget.expensesList![index].category,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.expensesList![index]
                                .formattedDate()
                                .toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      widget.expensesList![index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      '₹ ${widget.expensesList![index].amount}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
