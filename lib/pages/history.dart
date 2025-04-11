import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, index) {
          return ListTile(title: Text('item 1'));
        },
      ),
    );
  }
}
