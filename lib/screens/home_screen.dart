import 'package:flutter/material.dart';
import 'meal_plan_viewer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'Все';

  final List<Map<String, dynamic>> dishes = [
    {'name': 'Картошка с котлетой', 'calories': 400, 'category': 'Мясное', 'image': 'assets/images/potatoes.png'},
    {'name': 'Борщ', 'calories': 200, 'category': 'Супы', 'image': 'assets/images/borsch.png'},
    {'name': 'Гречка с сарделькой', 'calories': 350, 'category': 'Мясное', 'image': 'assets/images/grechka.png'},
    {'name': 'Пельмени', 'calories': 500, 'category': 'Мясное', 'image': 'assets/images/pelmeni.png'},
  ];

  final List<Map<String, dynamic>> mealPlans = [
    {'title': 'Демократия', 'description': 'Салат с курицей', 'image': 'assets/images/democr.png', 'plan': 'assets/images/plans/1_plan.png'},
    {'title': 'Комплекс Отличный', 'description': 'Мясное блюдо с макаронами', 'image': 'assets/images/most.png', 'plan': 'assets/images/plans/2_plan.png'},
    {'title': 'Завтрак школьника', 'description': '', 'image': 'assets/images/breackfast.png', 'plan': 'assets/images/plans/3_plan.png'},
  ];

  List<Map<String, dynamic>> get filteredDishes {
    if (selectedFilter == 'Все') {
      return dishes;
    } else {
      return dishes.where((dish) => dish['category'] == selectedFilter).toList();
    }
  }

  void selectFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF1CB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок «Меню»
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Меню',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Montserrat-Medium', color: Colors.black),
              ),
            ),
            // Фильтры категорий
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterButton(
                    label: 'Все',
                    isSelected: selectedFilter == 'Все',
                    onTap: () => selectFilter('Все'),
                  ),
                  FilterButton(
                    label: 'Мясное',
                    isSelected: selectedFilter == 'Мясное',
                    onTap: () => selectFilter('Мясное'),
                  ),
                  FilterButton(
                    label: 'Супы',
                    isSelected: selectedFilter == 'Супы',
                    onTap: () => selectFilter('Супы'),
                  ),
                  FilterButton(
                    label: 'Веган',
                    isSelected: selectedFilter == 'Веган',
                    onTap: () => selectFilter('Веган'),
                  ),
                  // Add more filters as needed
                ],
              ),
            ),
            // Раздел "Планы питания"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Планы питания',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Montserrat-Medium', color: Colors.black),
              ),
            ),
            SizedBox(
              height: 250, // Increased height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mealPlans.length,
                itemBuilder: (context, index) {
                  final plan = mealPlans[index];
                  return MealPlanCard(
                    title: plan['title'],
                    description: plan['description'],
                    image: plan['image'],
                    plan: plan['plan'],
                  );
                },
              ),
            ),
            // Раздел "Блюда"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Блюда',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Montserrat-Medium', color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1, // Make the cards square
                ),
                itemCount: filteredDishes.length,
                itemBuilder: (context, index) {
                  final dish = filteredDishes[index];
                  return DishCard(
                    name: dish['name'],
                    calories: dish['calories'],
                    image: dish['image'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  FilterButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.transparent,
        elevation: 0, // Remove shadow
        textStyle: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 14, fontWeight: FontWeight.w300),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class MealPlanCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String plan;

  MealPlanCard({
    required this.title, 
    required this.description, 
    required this.image,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealPlanViewerScreen(
              title: title,
              planImage: plan,
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 150,
              child: Image.asset(image, width: double.infinity, fit: BoxFit.contain),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat-Medium',
                  color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DishCard extends StatelessWidget {
  final String name;
  final int calories;
  final String image;

  DishCard({required this.name, required this.calories, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Image.asset(image, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Color(0xFF76B53F),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  '$calories ккал',
                  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat-Medium', fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat-Medium'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}