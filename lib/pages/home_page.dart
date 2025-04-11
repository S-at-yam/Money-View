import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Icon(Icons.home)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 4),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.97,
                color: Colors.red,
              ),
              const SizedBox(height: 8),
              Container(
                height: MediaQuery.of(context).size.height * 0.535,
                width: MediaQuery.of(context).size.width * 0.97,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
