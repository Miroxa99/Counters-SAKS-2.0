import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(
      body: Center(child: HelloButtom()),
    ));
  }
}

class HelloButtom extends StatelessWidget {
  const HelloButtom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/choice_house_list');
        },
        child: const Text('Опять работа'));
  }
}
