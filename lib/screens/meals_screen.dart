import 'package:flutter/material.dart';

class Dish {
  final String name;
  final int calories;
  final double proteins;
  final double fats;
  final double carbs;

  Dish({
    required this.name,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });
}

class MealsScreen extends StatefulWidget {
  final Function(int calories, double proteins, double fats, double carbs) onMealAdded;
  final String mealType;

  const MealsScreen({
    super.key,
    required this.onMealAdded,
    required this.mealType,
  });

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final List<Dish> dishes = [
    Dish(
      name: 'Суп куриный с рисом и томатом',
      calories: 143,
      proteins: 6,
      fats: 5,
      carbs: 16,
    ),
    Dish(
      name: 'Борщ с мясом и сметаной',
      calories: 143,
      proteins: 6,
      fats: 5,
      carbs: 16,
    ),
    Dish(
      name: 'Лепешка «Сырная»',
      calories: 143,
      proteins: 6,
      fats: 5,
      carbs: 16,
    ),
    Dish(
      name: 'Медальоны куриные с томатным соусом и зеленью',
      calories: 143,
      proteins: 6,
      fats: 5,
      carbs: 16,
    ),
    Dish(
      name: 'Каша гречневая рассыпчатая с маслом',
      calories: 143,
      proteins: 6,
      fats: 5,
      carbs: 16,
    ),
    Dish(
      name: 'Пельмени отварные с маслом',
      calories: 143,
      proteins: 6,
      fats: 5,
      carbs: 16,
    ),
    Dish(
      name: 'Рис отварной с маслом',
      calories: 143,
      proteins: 6,
      fats: 5,
      carbs: 16,
    ),
    Dish(
      name: 'Напиток плодово – ягодный витаминизированный',
      calories: 143,
      proteins: 6,
      fats: 5,
      carbs: 16,
    ),
    Dish(
      name: 'Спагетти отварные с маслом',
      calories: 143,
      proteins: 6,
      fats: 5,
      carbs: 16,
    ),
  ];

  bool showAllDishes = true;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 234, 241, 203),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.mealType,
          style: const TextStyle(
            fontFamily: 'DelaGothicOne',
            color: Color(0xFF78B04C)

,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 234, 241, 203),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF8AB77B),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                  style: const TextStyle(
                    fontFamily: 'DelaGothicOne',
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Поиск блюда',
                    hintStyle: TextStyle(
                      fontFamily: 'DelaGothicOne',
                      color: Colors.white.withOpacity(0.7),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ 

                _buildFilterButton('Все'
               
                , showAllDishes, () {
                  setState(() {
                    Color(0xFF78B04C);

                    showAllDishes = true;
                  });
                }),
                _buildFilterButton('Мои продукты', !showAllDishes, () {
                  setState(() {
                    Color(0xFF78B04C);

                    showAllDishes = false;
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 92, 142, 53),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: dishes
                      .where((dish) =>
                          dish.name.toLowerCase().contains(searchQuery))
                      .map((dish) => _buildDishItem(dish))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isActive, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: isActive ? const Color(0xFF8AB77B) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'DelaGothicOne',
          color: Colors.white,
          fontSize: isActive ? 16 : 14,
        ),
      ),
    );
  }

  Widget _buildDishItem(Dish dish) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF8AB77B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  dish.name,
                  style: const TextStyle(
                    fontFamily: 'DelaGothicOne',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Radio<bool>(
                value: false,
                groupValue: true,
                onChanged: (value) {
                  widget.onMealAdded(
                    dish.calories,
                    dish.proteins,
                    dish.fats,
                    dish.carbs,
                  );
                  Navigator.pop(context);
                },
                fillColor: MaterialStateProperty.all(Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Ккал ${dish.calories}',
            style: const TextStyle(
              fontFamily: 'DelaGothicOne',
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Text(
            'Белки ${dish.proteins}г  Жиры ${dish.fats}г  Углеводы ${dish.carbs}г',
            style: const TextStyle(
              fontFamily: 'DelaGothicOne',
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}