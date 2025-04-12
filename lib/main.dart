import 'package:flutter/material.dart';
import 'package:money_view/provider/expense_provider.dart';

import 'package:money_view/tab.dart';
import 'package:provider/provider.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 8, 131, 139),
);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: MaterialApp(
        home: TabPage(),
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.primary,
            foregroundColor: kColorScheme.onPrimary,
            iconTheme: IconThemeData(color: kColorScheme.onPrimary, size: 35),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.onPrimary,
              foregroundColor: kColorScheme.onSecondary,
            ),
          ),
          textTheme: TextTheme().copyWith(
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              iconColor: WidgetStateProperty.all(kColorScheme.primaryContainer),
            ),
          ),
          iconTheme: IconThemeData().copyWith(color: Colors.red),
        ),
      ),
    ),
  );
}
