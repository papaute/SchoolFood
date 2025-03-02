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
      fats: 200,
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
         
       
      backgroundColor: const Color.fromARGB(255, 234, 241, 203),
      appBar: AppBar(
        
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF78B04C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.mealType,
          style: const TextStyle(
            fontFamily: 'DelaGothicOne',
             
            fontSize: 20,
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
                 color: Color(0xFF78B04C),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF78B04C)),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color(0xFF78B04C),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Поиск блюда',
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      color: const Color(0xFF78B04C).withOpacity(0.7),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF78B04C),
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
                _buildFilterButton('Все', showAllDishes, () {
                  setState(() {
                    showAllDishes = true;
                  });
                }),
                _buildFilterButton('Мои продукты', !showAllDishes, () {
                  setState(() {
                    showAllDishes = false;
                  });
                }),
              ],
            ),
            
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
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
        backgroundColor: isActive ? const Color(0xFF78B04C) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: const Color(0xFF78B04C),
            width: isActive ? 0 : 2,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'DelaGothicOne',
          color: isActive ? const Color.fromARGB(255, 255, 255, 255) : const Color(0xFF78B04C),
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
        
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF78B04C)),
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
                    color: Color(0xFF78B04C),
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Color(0xFF78B04C),
                  size: 24,
                ),
                onPressed: () {
                  widget.onMealAdded(
                    dish.calories,
                    dish.proteins,
                    dish.fats,
                    dish.carbs,
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Ккал ${dish.calories}',
            style: const TextStyle(
              fontFamily: 'DelaGothicOne',
              color: Color(0xFF78B04C),
              fontSize: 14,
            ),
          ),
          Text(
            'Белки ${dish.proteins}г  Жиры ${dish.fats}г  Углеводы ${dish.carbs}г',
            style: const TextStyle(
              fontFamily: 'DelaGothicOne',
              color: Color(0xFF78B04C),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}