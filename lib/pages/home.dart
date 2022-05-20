import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: const [
              Text('My pools'),
              Text('My votes'),
            ],
          ),
        ),
      ),
    );
  }
}
