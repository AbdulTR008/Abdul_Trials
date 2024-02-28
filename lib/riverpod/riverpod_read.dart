import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expensize/models/expenses.dart';

final _hiveDB = Hive.box('expensizeDB');

class DBReadData extends StateNotifier<List<Expenses>> {
  DBReadData() : super([]);

  // List<Expenses> read() {
  //   List<Expenses> allOfMyExpense = _hiveDB.keys.map((eachKey) {
  //     var item = _hiveDB.get(eachKey);
  //     return Expenses(
  //         title: item['title'] ?? '',
  //         amount: item['amount'] ?? '',
  //         date: item['date'] ?? DateTime.now(),
  //         category: item['category'] ?? 'work');
  //   }).toList();
  //   state = allOfMyExpense;
  //   return state;
  // }
}

final dbReadProvider =
    StateNotifierProvider<DBReadData, List<Expenses>>((ref) => DBReadData());
