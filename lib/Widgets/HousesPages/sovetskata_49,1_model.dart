import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SaveCountersModel extends ChangeNotifier {
  var _data = [];
  List get data => _data.toList();

  String dataCounters = '';
  String flexNumber = '';

  void finishDataCounters() async {}

  Future<String> saveDataCounters() async {
    final box = await Hive.openBox('counters_box');
    // if (box.isEmpty) {
    //   return '';
    // } else {
    Hive.isAdapterRegistered(0);
    // await box.deleteFromDisk()
    // final result = await box.add(test);
    await box.put(flexNumber, dataCounters);
    String getDataFromBox = box.get(flexNumber);
    // await box.add(flexNumber);
    // await box.add(dataCounters);
    print(box.values);
    print(box.keys);
    // _setupData();
    return box.values.elementAt(int.parse(flexNumber));
    // }
  }

  Future<String> readDataCountersFromBox() async {
    Hive.hashCode;
    final a = print('dddd');
    print(Hive.isBoxOpen('counters_box'));
    print(flexNumber);
    print(dataCounters);
    final box = await Hive.openBox('counters_box');
    print(Hive.isBoxOpen('counters_box'));
    print(flexNumber);
    print(dataCounters);
    // myKeyList.addAll();
    final String getDataFromBox =
        await box.get(flexNumber);
    print(getDataFromBox);
    // final String futureTestText = await Future.value(getDataFromBox);
    return getDataFromBox;
  }

  Future readData() async {}
}

class SaveCountersModelProvider extends InheritedNotifier {
  final SaveCountersModel model;

  const SaveCountersModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, notifier: model, child: child);

  final Widget child;

  static SaveCountersModelProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SaveCountersModelProvider>();
  }

  @override
  bool updateShouldNotify(SaveCountersModelProvider oldWidget) {
    return true;
  }
}
