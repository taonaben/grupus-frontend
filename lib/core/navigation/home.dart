import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/core/navigation/nav_bar.dart';
import 'package:grupus/core/navigation/routes.dart';

class Home extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const Home({super.key, required this.navigationShell});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _handleTabChange(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: CustomNavBar(
        items: navBarItems,
        selectedIndex: widget.navigationShell.currentIndex,
        onTap: _handleTabChange,
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        // height: 92,
      ),
    );
  }
}
