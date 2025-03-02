import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'meals_screen.dart';
 



class AppConstants {
  static const double cardPadding = 20.0;
  static const double borderRadius = 20.0;
  static const double chartSize = 120.0;
  static const double indicatorSize = 10.0;
  static const double spacing = 16.0;
}

class MealItem extends StatefulWidget {
  final String title;
  final String calories;
  final Function(int calories, double proteins, double fats, double carbs) onNutritionChanged;

  const MealItem({
    super.key,
    required this.title,
    required this.calories,
    required this.onNutritionChanged,
  });

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  bool isExpanded = false;
  TextEditingController customMealController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Row(
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
                  '${widget.calories}\nккал ',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text( 
               widget.title,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealsScreen(
                      mealType: widget.title,
                      onMealAdded: widget.onNutritionChanged,
                    ),
                  ),
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
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
          ],
        ),
        if (isExpanded) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: customMealController,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Добавить прием пищи',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    if (customMealController.text.isNotEmpty) {
                      
                      setState(() {
                        customMealController.clear();
                        isExpanded = false;
                      });
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    customMealController.dispose();
    super.dispose();
  }
}

class DiaryScreen extends StatefulWidget {
  final bool showNavBar;

  const DiaryScreen({
    Key? key,
    required this.showNavBar,
  }) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  int _waterGlasses = 0;
  bool _showWaterSticker = false;
  int _totalCalories = 0;
  double _totalProteins = 0;
  double _totalFats = 0;
  double _totalCarbs = 0;
  final int dailyCalorieGoal = 1900;

  Map<String, MealData> meals = {
    'Завтрак': MealData(calories: 0, proteins: 0, fats: 0, carbs: 0),
    'Обед': MealData(calories: 0, proteins: 0, fats: 0, carbs: 0),
    'Ужин': MealData(calories: 0, proteins: 0, fats: 0, carbs: 0),
  };

  void updateMealNutrition(String mealType, int calories, double proteins, double fats, double carbs) {
    setState(() {
      meals[mealType] = MealData(
        calories: meals[mealType]!.calories + calories,
        proteins: meals[mealType]!.proteins + proteins,
        fats: meals[mealType]!.fats + fats,
        carbs: meals[mealType]!.carbs + carbs,
      );

      // Обновляем общие значения
      _totalCalories = meals.values.fold(0, (sum, meal) => sum + meal.calories);
      _totalProteins = meals.values.fold(0.0, (sum, meal) => sum + meal.proteins);
      _totalFats = meals.values.fold(0.0, (sum, meal) => sum + meal.fats);
      _totalCarbs = meals.values.fold(0.0, (sum, meal) => sum + meal.carbs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1CB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Дневник питания',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat-Medium',
                  ),
                ),
                const SizedBox(height: 20),
                // Calories card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Калории: $_totalCalories / $dailyCalorieGoal',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: _totalCalories / dailyCalorieGoal,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _totalCalories > dailyCalorieGoal 
                                ? Colors.red 
                                : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nutrients
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Нутриенты',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,  ),
                       ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildNutrientInfo('Белки', _totalProteins),
                            _buildNutrientInfo('Жиры', _totalFats),
                            _buildNutrientInfo('Углеводы', _totalCarbs),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Water tracker
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Вода',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('$_waterGlasses стаканов'),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (_waterGlasses > 0) {
                                      setState(() {
                                        _waterGlasses--;
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      _waterGlasses++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Meals section
                ...meals.entries.map((meal) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: MealItem(
                    title: meal.key,
                    calories: '${meal.value.calories}',
                    onNutritionChanged: (calories, proteins, fats, carbs) {
                      updateMealNutrition(meal.key, calories, proteins, fats, carbs);
                    },
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientInfo(String label, double value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '${value.toStringAsFixed(1)}г',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class CaloriesCard extends StatelessWidget {
  final int totalCalories;
  final int dailyCalorieGoal;
  final double totalProteins;
  final double totalFats;
  final double totalCarbs;
  final Color textColor;

  const CaloriesCard({
    super.key,
    required this.totalCalories,
    required this.dailyCalorieGoal,
    required this.totalProteins,
    required this.totalFats,
    required this.totalCarbs,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.cardPadding),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/calories.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCaloriesHeader(),
          const SizedBox(height: AppConstants.spacing),
          Row(
            children: [
              _buildPieChart(context),
              const SizedBox(width: AppConstants.spacing),
              _buildNutrientsList(),
            ],
          ),
          const SizedBox(height: AppConstants.spacing),
          _buildCaloriesRemaining(),
        ],
      ),
    );
  }

  Widget _buildCaloriesHeader() {
    return Text(
      '$totalCalories/$dailyCalorieGoal Ккал',
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildPieChart(BuildContext context) {
    final double total = totalProteins + totalFats + totalCarbs;
    final Map<String, double> dataMap = {
      "Углеводы": total > 0 ? (totalCarbs / total) * 100 : 0,
      "Жиры": total > 0 ? (totalFats / total) * 100 : 0,
      "Белки": total > 0 ? (totalProteins / total) * 100 : 0,
    };

    final List<Color> colorList = [
      const Color(0xFFFFF3E0),
      const Color(0xFFFFB74D),
      const Color(0xFFFFE0B2),
    ];

    return SizedBox(
      width: AppConstants.chartSize,
      height: AppConstants.chartSize,
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
      NutrientInfo("Углеводы", "${totalCarbs.toStringAsFixed(1)}г", const Color(0xFFFFF3E0)),
      NutrientInfo("Жиры", "${totalFats.toStringAsFixed(1)}г", const Color(0xFFFFB74D)),
      NutrientInfo("Белки", "${totalProteins.toStringAsFixed(1)}г", const Color(0xFFFFE0B2)),
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
            width: AppConstants.indicatorSize,
            height: AppConstants.indicatorSize,
            decoration: BoxDecoration(
              color: nutrient.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${nutrient.name} ${nutrient.amount}',
            style: const TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesRemaining() {
    final remaining = dailyCalorieGoal - totalCalories;
    return Text(
      'Осталось еще ${remaining}ккал',
      style: const TextStyle(
        fontFamily: 'Montserrat',
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
      padding: const EdgeInsets.all(AppConstants.cardPadding),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/water.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReminderText(),
          const SizedBox(height: AppConstants.spacing),
          _buildWaterGlasses(),
        ],
      ),
    );
  }

  Widget _buildReminderText() {
    return const Text(
      'Не забывайте\nпить воду!',
      style: TextStyle(
        fontFamily: 'Montserrat',
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

class MealData {
  final int calories;
  final double proteins;
  final double fats;
  final double carbs;

  MealData({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });
}