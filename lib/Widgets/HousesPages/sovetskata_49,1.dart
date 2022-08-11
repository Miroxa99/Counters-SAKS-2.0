import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Sovetskaya49Page extends StatelessWidget {
  const Sovetskaya49Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Советская 49/1')),
        body: Container(child: FlutNumberAndMeterReading()));
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
            index: index,
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
    return Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              autoClose: false,
              onPressed: ((context) {
                setState(() {
                  if(_LampOn == Colors.white) {_LampOn = Colors.red; _LampBackgroundOn = Colors.black; }
                  else {_LampOn = Colors.white; _LampBackgroundOn = Colors.yellow;}
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
            leading: Text('${index + 1}'),
            title: const TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            )));
  }
}
