import 'package:counters2/Widgets/HousesPages/sovetskata_49,1_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    var useModel = SaveCountersModelProvider.of(context)?.model;

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
  late final _future =
      SaveCountersModelProvider.of(context)?.model.readDataCountersFromBox();

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    box();
  }
  Future box() async {
    final box = await Hive.openBox('counters_box');
    print(box.isOpen);
    String getDataFromBox =
        await box.get(SaveCountersModelProvider.of(context)?.model.flexNumber);
    final _personBox = await Hive.openBox('counters_box');
    return getDataFromBox;
  }

  @override
  Widget build(BuildContext context) {
    var useModel = SaveCountersModelProvider.of(context)?.model;
    useModel?.flexNumber = widget.index.toString();
    final Future<String>? readDataCountersFromBoxFuture =
        useModel?.readDataCountersFromBox();

    return ListTile(
        leading: Text(useModel!.flexNumber),
        title: FutureBuilder<String>(builder: (BuildContext context, snapshot) {
          Widget children;
          var textFieldData = TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              useModel?.flexNumber = widget.index.toString();
              useModel?.dataCounters = value;
            },
            onEditingComplete: () {
              useModel?.saveDataCounters();
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
        }));
  }
}
