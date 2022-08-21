import 'package:counters2/Widgets/HousesPages/sovetskata_49,1_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Sovetskaya49Page extends StatelessWidget {
  const Sovetskaya49Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SaveCountersModelProvider(
      notifier: SaveCountersModel(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Советская 49/1')),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.done),
              onPressed: () {
                SaveCountersModelProvider.of(context).finishDataCounters();
              }),
          body: const FlutNumberAndMeterReading()),
    );
  }
}

class FlutNumberAndMeterReading extends StatelessWidget {
  const FlutNumberAndMeterReading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Text('Номер квартиры'),
          title: Text('Показания'),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 54,
                addAutomaticKeepAlives: true,
                itemBuilder: (BuildContext context, int index) {
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

class _SliderTextRowState extends State<SliderTextRow>
    with AutomaticKeepAliveClientMixin {
  final int index;
  _SliderTextRowState(this.index);
  Color _lampOn = Colors.white;
  Color _lampBackgroundOn = Colors.yellow;
  var _lampText = null;
  final _textController = TextEditingController();
  final _textControllerValue = TextEditingValue();

  @override
  Widget build(BuildContext context) {
    var useModel = SaveCountersModelProvider.of(context);

    return Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              autoClose: false,
              onPressed: ((context) {
                setState(() {
                  if (_lampOn == Colors.white) {
                    _lampOn = Colors.red;
                    _lampBackgroundOn = Colors.black;
                    _lampText = 'не горит';
                  } else {
                    _lampOn = Colors.white;
                    _lampBackgroundOn = Colors.yellow;
                    _lampText = null;
                  }
                });
              }),
              label: _lampText,
              backgroundColor: _lampBackgroundOn,
              foregroundColor: _lampOn,
              icon: Icons.lightbulb,
            )
          ],
        ),
        child: ElementsListTitle(
          index: index,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class ElementsListTitle extends StatefulWidget {
  final index;
  const ElementsListTitle({required this.index, Key? key}) : super(key: key);

  @override
  State<ElementsListTitle> createState() => _ElementsListTitleState();
}

class _ElementsListTitleState extends State<ElementsListTitle> {
  late StringDataAsync _readData;
  late StringDataAsync _saveData;
  late InputString _onChange;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _readData = SaveCountersModelProvider.of(context).readDataCountersBy;
    _saveData = SaveCountersModelProvider.of(context).saveDataCountersWith;
    _onChange = SaveCountersModelProvider.of(context).onChangeCounters;
  }

  @override
  Widget build(BuildContext context) {
    var index = widget.index.toString();
    return ListTile(
      leading: Text(index),
      title: FutureBuilder<String>(
        future: _readData(index: index),
        builder: (BuildContext context, snapshot) {
          Widget children;
          var textFieldData = TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _onChange(data: value);
            },
            onEditingComplete: () {
              _saveData(index: index);
              FocusScope.of(context).nextFocus();
            },
            textInputAction: TextInputAction.next,
            controller: TextEditingController(
                text: snapshot
                    .data), //TODO Эта функция вызывается раньше чем нужно
          );
          if (snapshot.hasData) {
            // print(snapshot.data);
            children = textFieldData;
          } else if (snapshot.hasError) {
            children = Text('Error: ${snapshot.error}');
          } else {
            children = textFieldData;
          }
          return Center(
            child: children,
          );
        },
      ),
    );
  }
}
