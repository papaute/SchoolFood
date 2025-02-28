import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'meals_screen.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  // Константы
  static const double _cardPadding = 20.0;
  static const double _borderRadius = 20.0;
  static const double _chartSize = 120.0;
  static const double _indicatorSize = 10.0;
  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(_spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Привет, Софья!',
                    style: TextStyle(
                      fontFamily: 'DelaGothicOne',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Image.asset(
                    'images/logo.png',
                    width: 48,
                    height: 48,
                  ),
                ],
              ),
              const SizedBox(height: _spacing),
              const CaloriesCard(),
              const SizedBox(height: _spacing),
              const WaterReminderCard(),
              const SizedBox(height: _spacing),
              _buildMealsList(context),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildMealsList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_cardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade400,
            Colors.green.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        children: [
          _buildMealItem(context, 'Завтрак', '800'),
          const Divider(color: Colors.white24, height: 32),
          _buildMealItem(context, 'Обед', '0'),
          const Divider(color: Colors.white24, height: 32),
          _buildMealItem(context, 'Ужин', '0'),
        ],
      ),
    );
  }

  static Widget _buildMealItem(BuildContext context, String title, String calories) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              '$calories\nккал',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'DelaGothicOne',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'DelaGothicOne',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MealsScreen()),
            );
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class CaloriesCard extends StatelessWidget {
  const CaloriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DiaryScreen._cardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade400,
            Colors.green.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(DiaryScreen._borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCaloriesHeader(),
          const SizedBox(height: DiaryScreen._spacing),
          Row(
            children: [
              _buildPieChart(context),
              const SizedBox(width: DiaryScreen._spacing),
              _buildNutrientsList(),
            ],
          ),
          const SizedBox(height: DiaryScreen._spacing),
          _buildCaloriesRemaining(),
        ],
      ),
    );
  }

  Widget _buildCaloriesHeader() {
    return const Text(
      '800/1900 Ккал',
      style: TextStyle(
        fontFamily: 'DelaGothicOne',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildPieChart(BuildContext context) {
    final Map<String, double> dataMap = {
      "Углеводы": 55,
      "Жиры": 20,
      "Белки": 25,
    };

    final List<Color> colorList = [
      const Color(0xFFFFF3E0),
      const Color(0xFFFFB74D),
      const Color(0xFFFFE0B2),
    ];

    return SizedBox(
      width: DiaryScreen._chartSize,
      height: DiaryScreen._chartSize,
      child: PieChart(
        dataMap: dataMap,
        colorList: colorList,
        chartRadius: MediaQuery.of(context).size.width / 4,
        legendOptions: const LegendOptions(showLegends: false),
        chartValuesOptions: const ChartValuesOptions(showChartValues: false),
      ),
    );
  }

  Widget _buildNutrientsList() {
    final nutrients = [
      NutrientInfo("Углеводы", "55г", const Color(0xFFFFF3E0)),
      NutrientInfo("Жиры", "25г", const Color(0xFFFFB74D)),
      NutrientInfo("Белки", "20г", const Color(0xFFFFE0B2)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: nutrients.map((nutrient) => _buildNutrientRow(nutrient)).toList(),
    );
  }

  Widget _buildNutrientRow(NutrientInfo nutrient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: DiaryScreen._indicatorSize,
            height: DiaryScreen._indicatorSize,
            decoration: BoxDecoration(
              color: nutrient.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${nutrient.name} ${nutrient.amount}',
            style: const TextStyle(
              fontFamily: 'DelaGothicOne',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesRemaining() {
    return const Text(
      'Осталось еще 1100ккал',
      style: TextStyle(
        fontFamily: 'DelaGothicOne',
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}

class WaterReminderCard extends StatelessWidget {
  const WaterReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DiaryScreen._cardPadding),
      decoration: BoxDecoration(
        color: const Color(0xFFFFB74D),
        borderRadius: BorderRadius.circular(DiaryScreen._borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReminderText(),
          const SizedBox(height: DiaryScreen._spacing),
          _buildWaterGlasses(),
        ],
      ),
    );
  }

  Widget _buildReminderText() {
    return const Text(
      'Не забывайте\nпить воду!',
      style: TextStyle(
        fontFamily: 'DelaGothicOne',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildWaterGlasses() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Image.asset(
              'assets/icons/cup.png',
              width: 24,
              height: 32,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}

class NutrientInfo {
  final String name;
  final String amount;
  final Color color;

  NutrientInfo(this.name, this.amount, this.color);
}