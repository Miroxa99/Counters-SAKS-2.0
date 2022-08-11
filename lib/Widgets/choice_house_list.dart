import 'package:flutter/material.dart';

class ChoiceHouseList extends StatelessWidget {
  const ChoiceHouseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: Wrap(
            children: [const Text('выберите дом')],
          )),
      body: const Center(child: HouseList()),
    ));
  }
}

class HouseList extends StatelessWidget {
  final List<String> Houses = const [
    'Советская 49/1',
    'Красных Партизан 9/1',
    'Дзержинского 12',
    'Дзержинского 14',
    'Дзержинского 16',
    'Горбатова 47',
    'Степная 2В',
  ];

  final List<String> HousesPagesNames = const [ //TODO Дописать страницы каждого дома
    '/choice_house_list/49.1',
    '/choice_house_list/9.1',
    '/choice_house_list/49.1',
    '/choice_house_list/49.1',
    '/choice_house_list/49.1',
    '/choice_house_list/49.1',
    '/choice_house_list/49.1',
  ];
  const HouseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: ListTile(
              title: Text(
                Houses[index],
              ),
              onTap: () {
                Navigator.pushNamed(context, HousesPagesNames[index]);
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemCount: Houses.length);
  }
}
