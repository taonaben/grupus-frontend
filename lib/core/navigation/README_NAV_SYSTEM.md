# Dynamic Navigation Bar Implementation Guide

## Overview
This is a production-ready, dynamic navigation bar system inspired by popular apps like WhatsApp and Reddit. It provides:

✅ **Dynamic Tab Management** - Add/remove tabs without touching nav bar code  
✅ **State Preservation** - Each tab maintains its own state  
✅ **Visual Feedback** - Filled icons for selected tab, outline for others  
✅ **Hiding Capability** - Easy to hide on full-screen pages (login, details, etc.)  
✅ **Clean Architecture** - Follows Flutter best practices  
✅ **Easy Customization** - Colors, sizes, icons all configurable  

## File Structure

```
lib/core/navigation/
├── nav_bar_model.dart          # NavBarItem data class
├── nav_bar.dart                # CustomNavBar widget
├── routes.dart                 # GoRouter setup + navBarItems definition
├── tab_examples.dart           # Example implementations
└── NAV_BAR_USAGE.md           # Quick reference guide
```

## Key Files Explained

### 1. **nav_bar_model.dart**
Defines the structure for each navigation item:
```dart
NavBarItem(
  label: 'Home',              // Text displayed under icon
  route: '/home',             // Route path
  outlineIcon: Icons.home_outlined,  // Icon when not selected
  filledIcon: Icons.home,     // Icon when selected
)
```

### 2. **nav_bar.dart**
The reusable `CustomNavBar` widget that renders the bottom navigation. Features:
- Responsive layout with icons and labels
- Customizable colors and heights
- Smooth transitions between states

### 3. **routes.dart**
Contains:
- **navBarItems list** - Define all your tabs here
- **GoRouter configuration** - StatefulShellRoute for tab management
- **Tab widgets** - HomeTab, ChatTab, ProfileTab (examples)

### 4. **home.dart**
The main scaffold that:
- Receives StatefulNavigationShell from GoRouter
- Manages selected tab index
- Renders CustomNavBar and tab content

## How to Add a New Tab

### Step 1: Add to navBarItems (routes.dart)
```dart
final List<NavBarItem> navBarItems = [
  // ... existing items ...
  NavBarItem(
    label: 'Explore',
    route: '/explore',
    outlineIcon: Icons.explore_outlined,
    filledIcon: Icons.explore,
  ),
];
```

### Step 2: Add StatefulShellBranch (routes.dart)
```dart
StatefulShellBranch(
  routes: [
    GoRoute(
      path: '/explore',
      name: 'explore',
      builder: (context, state) => const ExploreTab(),
    ),
  ],
),
```

### Step 3: Create Your Tab Widget
```dart
class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: // Your content here
    );
  }
}
```

**That's it!** No changes needed to nav_bar.dart or home.dart

## Hiding the Nav Bar on Specific Pages

For pages like login, details, or full-screen views, don't nest them in StatefulShellRoute:

```dart
GoRoute(
  path: '/login',
  name: 'login',
  builder: (context, state) => const LoginPage(),
),

GoRoute(
  path: '/details/:id',  // Nested routes are supported!
  name: 'details',
  builder: (context, state) => DetailsPage(
    id: state.pathParameters['id']!,
  ),
),
```

When navigating to these routes, the nav bar won't appear.

## State Preservation

Each tab maintains its own state automatically:
```dart
class ChatTabExample extends StatefulWidget {
  @override
  State<ChatTabExample> createState() => _ChatTabExampleState();
}

class _ChatTabExampleState extends State<ChatTabExample> {
  final List<String> messages = [];  // ✅ This persists when switching tabs!
  
  @override
  Widget build(BuildContext context) {
    // When you switch to another tab and come back, 
    // messages will still be here
  }
}
```

## Customization

### Colors and Styling
```dart
CustomNavBar(
  items: navBarItems,
  selectedIndex: _selectedIndex,
  onTap: _handleNavigation,
  backgroundColor: Colors.white,           // Bar background
  selectedItemColor: Colors.blue,          // Selected tab color
  unselectedItemColor: Colors.grey,        // Unselected tab color
  height: 80,                              // Bar height
)
```

### Icon Pairs
Use outline icons for unselected and filled icons for selected states:
- Google Material Icons: `Icons.home_outlined` & `Icons.home`
- Or use any icon pair from the icon library

## Navigation Usage

### Navigate from anywhere in your app:
```dart
context.go('/home');     // Go to Home tab
context.go('/chat');     // Go to Chat tab
context.go('/profile');  // Go to Profile tab
```

### With parameters:
```dart
context.go('/details/123');
// In routes.dart: path: '/details/:id'
// In builder: id: state.pathParameters['id']!
```

## Common Patterns

### 1. **Tab with internal navigation**
```dart
class ChatTab extends StatefulWidget {
  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(routes: [
      GoRoute(path: '/list', builder: ...),
      GoRoute(path: '/detail/:id', builder: ...),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _router.build(context);
  }
}
```

### 2. **Access parent data from tab**
```dart
// In home.dart:
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: widget.navigationShell!,
    bottomNavigationBar: CustomNavBar(
      items: navBarItems,
      selectedIndex: _selectedIndex,
      onTap: _handleNavigation,
    ),
  );
}

// In your tab, access parent state if needed:
// Use Provider, Riverpod, GetX, or other state management
```

### 3. **Conditional nav bar visibility**
```dart
// In home.dart:
Widget _buildBody() {
  // Show nav bar for all tabs
  return widget.navigationShell!;
}

// For full-screen pages, don't wrap in StatefulShellRoute
```

## Best Practices

1. **Keep tab widgets simple** - Use separate files for complex tabs
2. **Use state management** - For shared state between tabs, use Provider/Riverpod
3. **Preserve scroll position** - Use PageStorageKey or state management
4. **Test navigation** - Ensure all tab transitions work smoothly
5. **Icon consistency** - Always use outline/filled icon pairs

## Troubleshooting

### Nav bar not showing
- Ensure the widget is under StatefulShellRoute in routes.dart
- Check that Home receives navigationShell parameter

### Tab state not persisting
- Ensure tab widget is StatefulWidget, not StatelessWidget
- State is only preserved during app session, not across restart

### Icon not showing
- Check icon exists in your icon library
- Ensure both outlineIcon and filledIcon are defined in NavBarItem

### Navigation not working
- Use `context.go()` for navigation
- Ensure route path matches exactly
- Check route name is unique

## Example: Full App Setup

See `tab_examples.dart` for complete implementations of:
- HomeTabExample with ListView
- ChatTabExample with message input
- ProfileTabExample with user info

Copy and customize these for your actual app!

## Performance Optimization

The system is already optimized because:
- Each tab state is preserved (not rebuilt on switch)
- GoRouter handles efficient routing
- CustomNavBar uses const widgets
- No unnecessary rebuilds of navbar

For large apps, consider using:
- Provider/Riverpod for global state
- PageStorageKey for scroll position persistence
- LazyLoading for tab content

---

**Ready to use!** Start by looking at `NAV_BAR_USAGE.md` for quick reference, or explore `tab_examples.dart` for implementation examples.
