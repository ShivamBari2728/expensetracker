import 'package:expensetracker/colors/appColors.dart';
import 'package:expensetracker/provider/themeProvider.dart';
import 'package:expensetracker/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const ExpenseTrackerApp(),
    ),
  );
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Spendwise',

          themeMode: themeProvider.themeMode,

          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color(0xFFF7F7FB),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFF7F7FB),
              foregroundColor: Color(0xFF202033),
              elevation: 0,
            ),
            cardColor: Colors.white,
            dividerColor: const Color(0xFFEAEAF2),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF121218),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF121218),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            cardColor: const Color(0xFF1E1E28),
            dividerColor: const Color(0xFF353541),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF1E1E28),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          home: const HomeScreen(),
        );
      },
    );
  }
}