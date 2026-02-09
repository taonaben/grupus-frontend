import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'nav_bar_model.dart';

typedef NavBarCallback = void Function(int index)?;

/// Reusable Navigation Bar Widget
///
/// Features:
/// - Dynamic tabs configuration
/// - Filled icons for selected tab, outline for unselected
/// - Works with GoRouter
/// - Clean, modern design (like WhatsApp/Reddit)
class CustomNavBar extends StatelessWidget {
  final List<NavBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? height;

  const CustomNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: height ?? 70,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: theme.dividerColor, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == selectedIndex;
          final itemColor =
              isSelected
                  ? (selectedItemColor ?? theme.primaryColor)
                  : (unselectedItemColor ?? theme.unselectedWidgetColor);

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSelected ? item.filledIcon : item.outlineIcon,
                    color: itemColor,
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: itemColor,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
