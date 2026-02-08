import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/shared/theme/theme_provider.dart'
    show themeProvider, ThemeProvider;

class ThemeToggleSwitch extends ConsumerWidget {
  final double size;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onChanged;

  const ThemeToggleSwitch({
    super.key,
    this.size = 40,
    this.padding,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider);
    final isDark = themeNotifier.isDarkMode;

    return Container(
      padding: padding ?? EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ref.read(themeProvider).toggleTheme();
            onChanged?.call();
          },
          borderRadius: BorderRadius.circular(size / 2),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  key: ValueKey(isDark),
                  size: size * 0.6,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Alternative: A more styled theme toggle switch
class ThemedSwitch extends ConsumerWidget {
  final double width;
  final double height;
  final VoidCallback? onChanged;

  const ThemedSwitch({
    super.key,
    this.width = 60,
    this.height = 34,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider);
    final isDark = themeNotifier.isDarkMode;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        ref.read(themeProvider).toggleTheme();
        onChanged?.call();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          color:
              isDark
                  ? theme.colorScheme.secondary.withOpacity(0.2)
                  : theme.colorScheme.primary.withOpacity(0.2),
          border: Border.all(
            color:
                isDark
                    ? theme.colorScheme.secondary.withOpacity(0.5)
                    : theme.colorScheme.primary.withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            AnimatedAlign(
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: height - 4,
                height: height - 4,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular((height - 4) / 2),
                  color:
                      isDark
                          ? theme.colorScheme.secondary
                          : theme.colorScheme.primary,
                ),
                child: Icon(
                  isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  size: (height - 4) * 0.6,
                  color: isDark ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
