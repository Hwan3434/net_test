import 'package:flutter/material.dart';

class BTabButton {
  static BottomNavigationBarItem add() {
    return BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add');
  }

  static BottomNavigationBarItem abc() {
    return BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'abc');
  }

  static BottomNavigationBarItem ac() {
    return BottomNavigationBarItem(
        icon: Icon(Icons.ac_unit_rounded), label: 'ac');
  }
}

// BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
// BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'abc'),
// BottomNavigationBarItem(icon: Icon(Icons.ac_unit_rounded), label: 'ac'),
