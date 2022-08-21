import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef Future<String> StringDataAsync({required String index});
typedef void InputString({required String data});

class SaveCountersModel extends ChangeNotifier {
  var _data = [];
  List get data => _data.toList();

  String _dataCounters = '';

  void finishDataCounters() async {}

  Future<String> saveDataCountersWith({required String index}) async {
    final box = await Hive.openBox('counters_box');
    // if (box.isEmpty) {
    //   return '';
    // } else {
    Hive.isAdapterRegistered(0);
    // await box.deleteFromDisk()
    // final result = await box.add(test);
    await box.put(index, _dataCounters);
    String getDataFromBox = box.get(index);
    // await box.add(flexNumber);
    // await box.add(dataCounters);
    print(box.values);
    print(box.keys);
    // _setupData();
    return box.values.elementAt(int.parse(index));
    // }
  }

  void onChangeCounters({required String data}) => _dataCounters = data;

  Future<String> readDataCountersBy({required String index}) async {
    final box = await Hive.openBox('counters_box');
    print(box.isOpen);
    String getDataFromBox = await box.get(index);
    return getDataFromBox;
  }

  Future readData() async {}
}

class SaveCountersModelProvider extends InheritedNotifier<SaveCountersModel> {
  const SaveCountersModelProvider({
    Key? key,
    required SaveCountersModel notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static SaveCountersModel of(BuildContext context) {
    var provider =
        context.dependOnInheritedWidgetOfExactType<SaveCountersModelProvider>();
    assert(provider != null, 'Не найден SaveCountersModelProvider');
    return provider!.notifier!;
  }
}
