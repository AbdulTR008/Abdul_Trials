import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _hiveDB = Hive.box('expensizeDB');

class dbChangeNotifier extends StateNotifier<Map<dynamic, dynamic>> {
  dbChangeNotifier() : super({});

  add(mapdata) {
    print('mapdata  $mapdata');
    print('mapdata  $state');
    print(state);

    _hiveDB.add(mapdata);
  }

  edit(editData) {}
}

final dbAddProvider =
    StateNotifierProvider<dbChangeNotifier, Map<dynamic, dynamic>>(
        (ref) => dbChangeNotifier());
