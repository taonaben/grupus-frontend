import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/core/navigation/routes.dart';
import 'package:grupus/shared/theme/theme_provider.dart';


final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());
void main()async {
  await dotenv.load(fileName: ".env");
   runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: theme.systemMode,
      darkTheme: theme.darkMode,
      
      themeMode: theme.themeData.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
