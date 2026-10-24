
import 'package:flutter/material.dart';

class ExpenseSummary extends StatelessWidget {
  final double totalExpenses;
  final double monthlyExpenses;

  const ExpenseSummary({
    super.key,
    required this.totalExpenses,
    required this.monthlyExpenses,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const cardColor = Color(0xFF172332);
    const accentColor = Color(0xFF82B4FF);

    final now = DateTime.now();
    final monthName = _monthName(now.month).toUpperCase();

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -38,
            top: -55,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.09),
                  width: 28,
                ),
              ),
            ),
          ),

          Positioned(
            right: 42,
            top: 35,
            child: Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withValues(alpha: 0.035),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'TOTAL EXPENSES',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.62),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 8),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '₹${totalExpenses.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1.2,
                      height: 1.15,
                      fontFeatures: [
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Divider.
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.14),
                ),

                const SizedBox(height: 18),

                // Monthly spending section.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'THIS MONTH',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.62),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            '$monthName ${now.year}',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.92),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          '₹${monthlyExpenses.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: accentColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            fontFeatures: [
                              FontFeature.tabularFigures(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip() {
    return Container(
      width: 43,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFD9C58D),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFB6A16B),
          width: 0.8,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 20,
                height: 26,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF9B8755),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            Center(
              child: Container(
                height: 1,
                color: const Color(0xFF9B8755),
              ),
            ),

            Center(
              child: Container(
                width: 1,
                color: const Color(0xFF9B8755),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: 10,
              child: Container(
                height: 1,
                color: const Color(0xFF9B8755),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Container(
                height: 1,
                color: const Color(0xFF9B8755),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }
}
