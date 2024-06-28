import 'package:flutter/material.dart';

class BottomNavigationFab extends StatelessWidget {
  const BottomNavigationFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 3.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.pie_chart),
              onPressed: () {
                Navigator.pushNamed(context, '/stats');
              }),
        ],
      ),
    );
  }
}
