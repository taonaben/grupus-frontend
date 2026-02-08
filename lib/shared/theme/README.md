# Theme & Design System Setup

This directory contains all theme-related configurations and shared components for the Grupus app.

## Directory Structure

```
shared/
├── theme/
│   ├── app_colors.dart          # All color definitions (light & dark modes)
│   ├── app_theme.dart           # ThemeData configurations
│   ├── theme_provider.dart      # State management for theme
│   └── theme_extensions.dart    # BuildContext extensions for easy theme access
├── components/
│   └── theme_toggle_switch.dart # Theme toggle widgets
└── constants/
    └── app_constants.dart       # App-wide constants
```

## Features

### 🎨 Color System

The app uses a structured color system with both light and dark mode support:

**Light Mode Colors:**
- Primary: `#6200EE` (Purple)
- Secondary: `#03DAC6` (Teal)
- Background: `#FAFAFA` (Light Gray)
- Surface: `#FFFFFF` (White)
- Error: `#B00020` (Red)

**Dark Mode Colors:**
- Primary: `#BB86FC` (Light Purple)
- Secondary: `#03DAC6` (Teal)
- Background: `#121212` (Near Black)
- Surface: `#1E1E1E` (Dark Gray)
- Error: `#CF6679` (Light Red)

**Additional Colors:**
- Success, Warning, Info, Text (Primary, Secondary, Tertiary)
- Border, Divider, Hint colors

### 🌓 Theme Modes

The app supports three theme modes:
1. **Light Mode** - Fixed light theme
2. **Dark Mode** - Fixed dark theme
3. **System Mode** - Follows device settings (default)

### 📱 Typography

All text uses Google Fonts (Poppins) with proper hierarchy:
- Display sizes (Large, Medium, Small)
- Heading styles (Medium, Small)
- Title styles (Large, Medium, Small)
- Body text (Large, Medium, Small)
- Label styles (Large, Medium, Small)

### 🎛️ Theme Provider

The `ThemeProvider` class manages theme state:

```dart
// Toggle between light and dark modes
ref.read(themeProvider).toggleTheme();

// Set specific mode
ref.read(themeProvider).setLightMode();
ref.read(themeProvider).setDarkMode();
ref.read(themeProvider).setSystemMode();

// Check current mode
final isDark = ref.read(themeProvider).isDarkMode;
final theme = ref.read(themeProvider).currentTheme;
```

### 🔘 Theme Toggle Widget

Two pre-built toggle widgets are provided:

**Simple Button Toggle:**
```dart
ThemeToggleSwitch(
  size: 40,
  onChanged: () {
    // Optional callback
  },
)
```

**Styled Switch Toggle:**
```dart
ThemedSwitch(
  width: 60,
  height: 34,
  onChanged: () {
    // Optional callback
  },
)
```

### 📖 Using Theme Extensions

Easy access to theme colors and styles:

```dart
// In any BuildContext (like in build method)
Text(
  'Hello',
  style: TextStyle(color: context.primaryColor),
)

// Check current theme
if (context.isDarkMode) {
  // Dark mode specific code
}

// Access colors
context.primaryColor        // Primary brand color
context.secondaryColor      // Secondary brand color
context.textPrimary         // Primary text color
context.textSecondary       // Secondary text color
context.backgroundColor     // Background color
context.surfaceColor        // Card/Surface color
context.borderColor         // Border color
context.errorColor          // Error color
context.successColor        // Success color
context.warningColor        // Warning color
context.infoColor           // Info color
```

## Implementation Example

### In AppBar:
```dart
AppBar(
  title: Text('Title'),
  backgroundColor: context.surfaceColor,
  elevation: 0,
)
```

### In Custom Widget:
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      child: Text(
        'Text',
        style: TextStyle(color: context.textPrimary),
      ),
    );
  }
}
```

### With Provider:
```dart
class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          ThemeToggleSwitch(),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: theme.isDarkMode,
              onChanged: (value) {
                if (value) {
                  ref.read(themeProvider).setDarkMode();
                } else {
                  ref.read(themeProvider).setLightMode();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

## System UI Styling

The theme automatically updates:
- Status bar color and icons
- Navigation bar color and icons
- These adapt based on the current theme mode

## Customization

To customize colors:
1. Edit `lib/shared/theme/app_colors.dart`
2. Update the color constants
3. Changes will automatically apply everywhere

To customize typography:
1. Edit `lib/shared/theme/app_theme.dart`
2. Modify the `textTheme` configuration
3. All text styles will update automatically

## Tips

- Always use `context.primaryColor` instead of hardcoding colors
- Use the text theme for consistent typography
- Use `AppConstants` for spacing and durations
- Check `isDarkMode` for theme-specific layouts if needed
- Keep colors centralized in `AppColors`
