import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:grupus/shared/components/theme_toggle_switch.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:grupus/shared/theme/theme_extensions.dart';
import 'package:grupus/shared/theme/theme_provider.dart' show ThemeProvider, themeProvider;

/// Example screen demonstrating theme usage
class ThemeExampleScreen extends ConsumerWidget {
  const ThemeExampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Example'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium,
            ),
            child: ThemeToggleSwitch(size: 40),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Theme Info Section
              _buildSectionTitle(context, 'Current Theme'),
              const Gap(AppConstants.paddingMedium),
              _buildThemeInfo(context, themeNotifier),
              const Gap(AppConstants.paddingXLarge),

              // Colors Section
              _buildSectionTitle(context, 'Color Palette'),
              const Gap(AppConstants.paddingMedium),
              _buildColorGrid(context),
              const Gap(AppConstants.paddingXLarge),

              // Typography Section
              _buildSectionTitle(context, 'Typography'),
              const Gap(AppConstants.paddingMedium),
              _buildTypography(context),
              const Gap(AppConstants.paddingXLarge),

              // Buttons Section
              _buildSectionTitle(context, 'Components'),
              const Gap(AppConstants.paddingMedium),
              _buildButtons(context, ref),
              const Gap(AppConstants.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title, style: context.textTheme.headlineSmall);
  }

  Widget _buildThemeInfo(BuildContext context, ThemeProvider theme) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mode: ${theme.themeMode.toString().split('.').last.toUpperCase()}',
            style: context.textTheme.bodyLarge,
          ),
          const Gap(AppConstants.paddingSmall),
          Text(
            'Brightness: ${theme.currentBrightness == Brightness.dark ? 'Dark' : 'Light'}',
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildColorGrid(BuildContext context) {
    final colors = [
      ('Primary', context.primaryColor),
      ('Secondary', context.secondaryColor),
      ('Background', context.backgroundColor),
      ('Surface', context.surfaceColor),
      ('Error', context.errorColor),
      ('Success', context.successColor),
      ('Warning', context.warningColor),
      ('Info', context.infoColor),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        mainAxisSpacing: AppConstants.paddingMedium,
        crossAxisSpacing: AppConstants.paddingMedium,
      ),
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final (label, color) = colors[index];
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadiusMedium,
            ),
            border: Border.all(color: context.borderColor),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color:
                  color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypography(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Display Large', style: context.textTheme.displayLarge),
        const Gap(AppConstants.paddingSmall),
        Text('Headline Small', style: context.textTheme.headlineSmall),
        const Gap(AppConstants.paddingSmall),
        Text('Body Large', style: context.textTheme.bodyLarge),
        const Gap(AppConstants.paddingSmall),
        Text('Body Medium', style: context.textTheme.bodyMedium),
        const Gap(AppConstants.paddingSmall),
        Text('Label Small', style: context.textTheme.labelSmall),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            ref.read(themeProvider).setLightMode();
          },
          child: const Text('Light Mode'),
        ),
        const Gap(AppConstants.paddingMedium),
        ElevatedButton(
          onPressed: () {
            ref.read(themeProvider).setDarkMode();
          },
          child: const Text('Dark Mode'),
        ),
        const Gap(AppConstants.paddingMedium),
        ElevatedButton(
          onPressed: () {
            ref.read(themeProvider).setSystemMode();
          },
          child: const Text('System Mode'),
        ),
        const Gap(AppConstants.paddingMedium),
        OutlinedButton(
          onPressed: () {
            ref.read(themeProvider).toggleTheme();
          },
          child: const Text('Toggle Theme'),
        ),
      ],
    );
  }
}
