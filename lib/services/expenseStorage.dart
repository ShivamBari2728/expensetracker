import 'dart:convert';
import 'package:expensetracker/models/expenseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseStorage {
  static const String _storageKey = 'expenses';

  Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_storageKey);

    if (data == null) {
      return [];
    }

    try {
      final List<dynamic> decoded = jsonDecode(data);

      return decoded
          .map((item) => Expense.fromJson(item))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();

    final String data = jsonEncode(
      expenses.map((expense) => expense.toJson()).toList(),
    );

    await prefs.setString(_storageKey, data);
  }
}