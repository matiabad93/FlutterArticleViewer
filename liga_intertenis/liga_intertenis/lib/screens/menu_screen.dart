import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final categories = [
    'Men\'s Singles',
    'Men\'s Doubles',
    'Women\'s Singles',
    'Women\'s Doubles',
    'Mixed Doubles',
    'Boys\' Singles',
    'Girls\' Singles',
    'Boys\' Doubles',
    'Girls\' Doubles',
    'Wheelchair Singles',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: ListView(
        children: categories.map((category) {
          return ListTile(
            title: Text(category),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              // Acción al seleccionar categoría
            },
          );
        }).toList(),
      ),
    );
  }
}

