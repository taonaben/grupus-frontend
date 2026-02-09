import 'package:flutter/material.dart';

/// Model for a navigation bar item
class NavBarItem {
  final String label;
  final String route;
  final IconData outlineIcon;
  final IconData filledIcon;

  NavBarItem({
    required this.label,
    required this.route,
    required this.outlineIcon,
    required this.filledIcon,
  });
}
