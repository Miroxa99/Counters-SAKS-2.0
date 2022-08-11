import 'package:counters2/Widgets/HousesPages/krasnix_partizan_9,1.dart';
import 'package:counters2/Widgets/HousesPages/sovetskata_49,1.dart';
import 'package:counters2/Widgets/choice_house_list.dart';
import 'package:counters2/Widgets/my_app_homepage.dart';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List d = [];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAKS Couners',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/choice_house_list': (context) => const ChoiceHouseList(),
        '/choice_house_list/49.1': (context) => const Sovetskaya49Page(),
        '/choice_house_list/9.1': (context) => const KrasnihPartizan9Page(),
      },
    );
  }
}
