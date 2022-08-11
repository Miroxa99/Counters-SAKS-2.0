import 'package:counters2/Widgets/HousesPages/sovetskata_49,1_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Sovetskaya49Page extends StatefulWidget {
  const Sovetskaya49Page({super.key});

  @override
  State<Sovetskaya49Page> createState() => _Sovetskaya49PageState();
}

class _Sovetskaya49PageState extends State<Sovetskaya49Page> {
  final _model = SaveCountersModel();
  @override
  Widget build(BuildContext context) {
    return SaveCountersModelProvider(
      model: _model,
      child: Scaffold(
          appBar: AppBar(title: const Text('Советская 49/1')),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.done),
              onPressed: () {
                SaveCountersModelProvider.of(context)
                    ?.model
                    .finishDataCounters();
              }),
          body: Container(child: FlutNumberAndMeterReading())),
    );
  }
}

class FlutNumberAndMeterReading extends StatefulWidget {
  const FlutNumberAndMeterReading({super.key});

  @override
  State<FlutNumberAndMeterReading> createState() =>
      _FlutNumberAndMeterReadingState();
}

class _FlutNumberAndMeterReadingState extends State<FlutNumberAndMeterReading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text('Номер квартиры'),
          title: Text('Показания'),
        ),
        Expanded(child:
            ListView.builder(itemBuilder: (BuildContext context, int index) {
          return SliderTextRow(
            index: index + 1,
          );
        }))
      ],
    );
  }
}

class SliderTextRow extends StatefulWidget {
  final int index;
  const SliderTextRow({super.key, required this.index});

  @override
  State<SliderTextRow> createState() => _SliderTextRowState(index);
}

class _SliderTextRowState extends State<SliderTextRow> {
  final int index;
  _SliderTextRowState(this.index);

  Color _LampOn = Colors.white;
  Color _LampBackgroundOn = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    var useModel = SaveCountersModelProvider.of(context)?.model;
    return Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              autoClose: false,
              onPressed: ((context) {
                setState(() {
                  if (_LampOn == Colors.white) {
                    _LampOn = Colors.red;
                    _LampBackgroundOn = Colors.black;
                  } else {
                    _LampOn = Colors.white;
                    _LampBackgroundOn = Colors.yellow;
                  }
                  //TODO Доделать нажатие лампочки
                });
              }),
              backgroundColor: _LampBackgroundOn,
              foregroundColor: _LampOn,
              icon: Icons.lightbulb,
            )
          ],
        ),
        child: ListTile(
            leading: Text('${index}'),
            title: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              
              onChanged: (value) {
                useModel?.flexNumber = index.toString();
                useModel?.dataCounters = value;
              },
              onEditingComplete: () {
                useModel?.saveDataCounters();
              },
              textInputAction: TextInputAction.next,
            )));
  }
}
