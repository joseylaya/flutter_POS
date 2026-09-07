import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/catalog/presentation/catalog_home_screen.dart';
import '../features/activation/presentation/activation_gate.dart';
import '../features/settings/application/settings_providers.dart';

class JmPosApp extends ConsumerWidget {
  const JmPosApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preference = ref.watch(settingsProvider).valueOrNull?.themeMode;
    return MaterialApp(
      title: 'JmPOS',
      debugShowCheckedModeBanner: false,
      themeMode: switch (preference) {
        'LIGHT' => ThemeMode.light,
        'DARK' => ThemeMode.dark,
        _ => ThemeMode.system,
      },
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      home: const ActivationGate(child: CatalogHomeScreen()),
    );
  }
}

ThemeData _theme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  const amber = Color(0xFFF59E0B);
  final scheme = ColorScheme.fromSeed(
    seedColor: amber,
    brightness: brightness,
    primary: dark ? amber : const Color(0xFFE88900),
    surface: dark ? const Color(0xFF18191E) : Colors.white,
    error: dark ? const Color(0xFFF87171) : const Color(0xFFC93636),
  );
  final border = dark ? const Color(0xFF2A2D36) : const Color(0xFFE3E5E8);
  return ThemeData(
    brightness: brightness,
    colorScheme: scheme,
    useMaterial3: true,
    fontFamily: 'Arial',
    scaffoldBackgroundColor: dark
        ? const Color(0xFF121316)
        : const Color(0xFFF5F6F8),
    dividerColor: border,
    cardTheme: CardThemeData(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: dark ? const Color(0xFF1F2127) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: border),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: dark ? const Color(0xFF1E2026) : const Color(0xFFF2F3F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: border),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: dark ? const Color(0xFF18191E) : Colors.white,
      indicatorColor: amber,
      selectedIconTheme: const IconThemeData(color: Color(0xFF181000)),
      selectedLabelTextStyle: const TextStyle(
        color: Color(0xFF181000),
        fontWeight: FontWeight.w800,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 46),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );
}
