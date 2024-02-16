import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:expensize/models/expenses.dart';
import 'package:expensize/screens/add.dart';
import 'package:expensize/widgets/expenses_item.dart';
import 'package:expensize/widgets/cupertino_widget.dart';
import 'package:expensize/widgets/reusable_home_cards.dart';

class ExpensesScreen extends StatefulWidget {
  ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final _dbBox = Hive.box('expensizeDB');

  @override
  void initState() {
    super.initState();
    expensesItemRefresh();
    // _dbBox.clear();
  }

  List<Expenses> filteredMonthList = [];
  List<Expenses> myExpensesList = [];

  void expensesItemRefresh() {

    myExpensesList = _dbBox.keys.map((eachKey) {
      var item = _dbBox.get(eachKey);
      print(' _ExpensesScreenState expensesItemRefresh ${eachKey.runtimeType}');
      return Expenses(
          title: item['title'] ?? '',
          amount: item['amount'] ?? '',
          date: item['date'] ?? DateTime.now(),
          category: item['category'] ?? 'work');
    }).toList();
    setState(() {});
  }

  void onPressed() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => AddScreen(
        triggerRefresh: () {
          expensesItemRefresh();
        },
      ),
    );
  }

  monthChangeFun({getMonth}) {
    Future.delayed(Duration(milliseconds: 50), () {
      filteredMonthList = myExpensesList.where((pickedItem) {
        final formattedMonth = DateFormat('MMM-yyyy').format(pickedItem.date);
        setState(() {});
        return getMonth == formattedMonth;
      }).toList();
      monthExpenseCalculate(filteredMonthList);
    });

    return filteredMonthList;
  }

  int total = 0;
  monthExpenseCalculate(List<Expenses> filteredList) {
    total = filteredMonthList.fold(0,
        (previousValue, current) => previousValue + int.parse(current.amount));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffF16627).withOpacity(0.8),
          onPressed: onPressed,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Expensize',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.background),
          ),
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: ReusableHomeCards(
                      headTitle: 'Total',
                      subTitle: '₹ $total',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CupertinoWidget(
                      selectedMonths: (getMonth) {
                        print('====>>>> ExpenseScreen Cuper $getMonth');
                        monthChangeFun(getMonth: getMonth);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: ExpenseItem(
                deletFun: () {
                  setState(() {
                  
                    expensesItemRefresh();
                  });
                },
                redEdit: () {
                  // var _stringDateTime = DateFormat('MMM-yyyy').format();
                  // monthChangeFun(getMonth: _stringDateTime);
                  print('redEdit Called');
                  expensesItemRefresh();
                },
                expensesList: myExpensesList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// List.generate(12, (index) {
//   DateFormat('MMM', 'en-us')
//       .format(DateTime(2001,1,1,1,))
//       .split('0')
//       .map((e) => months.add(e))
//       .toList();
// });

// return months};

// Expanded(
//   child: Card(
//     child: CupertinoPicker(
//         backgroundColor: Colors.red,
//         itemExtent: 32,
//         onSelectedItemChanged: (index) {},
//         children: const [
//           Text('data'),
//           Text('dataaaaa'),
//           Text('dataaa'),
//         ]),
//   ),
// ),



//  for (var i = 0; i <= filteredMonthList.length; i++) {
//         total += int.parse(filteredMonthList[i].amount);
//       }

 // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   monthChangeFun(_today);
  // }

  // final _today = DateFormat('dd-MMM-yyy').format(DateTime.now());


   // myExpensesList.add(
                  // Expenses(
                    // title: title,
                    // amount: amount,
                    // date: date!,
                    // category: category));
                // var stringDateTime = DateFormat('MMM-yyyy').format(date);



// Expenses(
//     title: 'Dress',
//     amount: '120',
//     date: DateTime(2024, 2, 2),
//     category: 'work'),
// Expenses(
//     title: 'Dress', amount: '100', date: DateTime.now(), category: 'work'),
// Expenses(
//     title: 'Dress', amount: '120', date: DateTime.now(), category: 'work'),
// Expenses(
//     title: 'Dress',
//     amount: '120',
//     date: DateTime(2024, 2, 2),
//     category: 'work'),