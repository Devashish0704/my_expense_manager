import 'package:flutter/material.dart';

class BottomNavigationFab extends StatelessWidget {
  BottomNavigationFab({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey; // Add this line

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 3.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
              scaffoldKey.currentState?.openDrawer();
              }),
          IconButton(
              icon: const Icon(Icons.pie_chart),
              onPressed: () {
                Navigator.pushNamed(context, '/stats');
              }),
          IconButton(
              icon: const Icon(Icons.access_alarm_rounded),
              onPressed: () {
              scaffoldKey.currentState?.openDrawer();
              }),
          IconButton(
              icon: const Icon(Icons.access_alarm_rounded),
              onPressed: () {
              scaffoldKey.currentState?.openDrawer();
              }),
        ],
      ),
    );
  }
}
