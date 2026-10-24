import 'package:expensetracker/colors/appColors.dart';
import 'package:expensetracker/models/expenseModel.dart';
import 'package:expensetracker/screens/settingsScreen.dart';
import 'package:expensetracker/services/expenseStorage.dart';
import 'package:expensetracker/widgets/addExpenseSheat.dart';
import 'package:expensetracker/widgets/expenseCard.dart';
import 'package:expensetracker/widgets/expenseSummery.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExpenseStorage _storage = ExpenseStorage();

  List<Expense> _expenses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final expenses = await _storage.loadExpenses();

    if (!mounted) return;

    setState(() {
      _expenses = expenses;
      _isLoading = false;
    });
  }

  Future<void> _addExpense(Expense expense) async {
    setState(() {
      _expenses.insert(0, expense);
    });

    await _storage.saveExpenses(_expenses);
  }

  Future<void> _deleteExpense(Expense expense) async {
    final index = _expenses.indexOf(expense);

    if (index == -1) return;

    setState(() {
      _expenses.removeAt(index);
    });

    await _storage.saveExpenses(_expenses);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Expense deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  double get _totalExpenses {
    return _expenses.fold(0, (total, expense) => total + expense.amount);
  }

  double get _monthlyExpenses {
    final now = DateTime.now();

    return _expenses
        .where(
          (expense) =>
              expense.date.year == now.year && expense.date.month == now.month,
        )
        .fold(0, (total, expense) => total + expense.amount);
  }

  void _showAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return AddExpenseSheet(onAddExpense: _addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  automaticallyImplyLeading: false,
  toolbarHeight: 76,
  titleSpacing: 20,
  backgroundColor: const Color(0xFF172332),
  foregroundColor: Colors.white,
  surfaceTintColor: Colors.transparent,
  elevation: 0,
  title: Row(
    children: [
      // Wallet logo
      Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF82B4FF).withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF82B4FF).withValues(alpha: 0.22),
          ),
        ),
        child: const Icon(
          Icons.account_balance_wallet_rounded,
          color: Color(0xFF82B4FF),
          size: 23,
        ),
      ),

      const SizedBox(width: 12),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Spendwise',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'PERSONAL FINANCE',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.7,
                color: Color(0xFF9BA9BA),
              ),
            ),
          ],
        ),
      ),

      Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: IconButton(
          tooltip: 'Settings',
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.settings_outlined,
            size: 21,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
          },
        ),
      ),
    ],
  ),
),


      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : RefreshIndicator(
              onRefresh: _loadExpenses,
              color: AppColors.primary,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                children: [
                  ExpenseSummary(
                    totalExpenses: _totalExpenses,
                    monthlyExpenses: _monthlyExpenses,
                  ),

                  const SizedBox(height: 28),

                  Expanded(
                    child: Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  if (_expenses.isEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 40,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.receipt_long_rounded,
                            size: 55,
                            color: AppColors.primary,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No expenses yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Tap the + button to add your first expense.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    )
                  else
                    ..._expenses.map(
                      (expense) => ExpenseCard(
                        expense: expense,
                        onDelete: () => _deleteExpense(expense),
                      ),
                    ),
                ],
              ),
            ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddExpenseSheet,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Expense',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
