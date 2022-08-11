import 'package:flutter/material.dart';

class SaveCountersModel {
  var dataCounters = '';
  var flexNumber = '';
  void finishDataCounters() {}
  void saveDataCounters() {
    print(flexNumber);
    print(dataCounters);
  }
}

class SaveCountersModelProvider extends InheritedWidget {
  final SaveCountersModel model;

  const SaveCountersModelProvider(
      {Key? key, required this.model, required this.child})
      : super(key: key, child: child);

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
