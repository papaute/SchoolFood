import 'package:flutter/material.dart';

class CaloriesCard extends StatefulWidget {
  // ... (existing code)
}

class _CaloriesCardState extends State<CaloriesCard> {
  // ... (existing code)

  Widget _buildCaloriesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$totalCalories',
          style: TextStyle(
            fontFamily: 'DelaGothicOne',
            fontSize: 24,
            color: textColor,
          ),
        ),
        Text(
          '/$dailyCalorieGoal',
          style: TextStyle(
            fontFamily: 'DelaGothicOne',
            fontSize: 24,
            color: textColor,
          ),
        ),
      ],
    );
  }

  // ... (rest of the existing code)
} 