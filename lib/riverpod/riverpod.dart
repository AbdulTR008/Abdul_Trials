import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expensize/models/expenses.dart';

final _hiveDB = Hive.box('expensizeDB');

class DBChangeNotifier extends StateNotifier<Map<dynamic, dynamic>> {
  DBChangeNotifier() : super(const {});

  void add(mapdata) {
    state = {...state, ...mapdata};
    _hiveDB.add(state);
  }

  read() {
    // List<Expenses> allOfMyExpense =

    state = Map.fromIterable(_hiveDB.keys.map((eachKey) {
      var item = _hiveDB.get(eachKey);
      return Expenses(
          title: item['title'] ?? '',
          amount: item['amount'] ?? '',
          date: item['date'] ?? DateTime.now(),
          category: item['category'] ?? 'work');
    }));

    // state = {...state, 'expenses': allOfMyExpense};

    // return allOfMyExpense;
  }
}

edit(editData) {}

final dbCrudProvider =
    StateNotifierProvider<DBChangeNotifier, Map<dynamic, dynamic>>(
        (ref) => DBChangeNotifier());
