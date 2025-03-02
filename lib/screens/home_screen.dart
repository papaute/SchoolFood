import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======
import 'screens/loading_screen.dart';
import 'screens/home_screen.dart';
import 'screens/diary_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: MealsScreen(
        onMealAdded: (int calories, double proteins, double fats, double carbs) {
          // Handle meal added
        },
        mealType: 'Lunch',
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const double _navBarHeight = 50.0;
  static const double _navBarMargin = 16.0;
  static const double _iconSize = 45.0;
  static const double _iconPadding = 8.0;

  int _selectedIndex = 1;

  final List<Widget> _screens = [
    MealsScreen(
      onMealAdded: (int calories, double proteins, double fats, double carbs) {},
      mealType: 'Обед',
    ),
    DiaryScreen(showNavBar: true),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
>>>>>>> 8d9b8489fb21a1c8891ed85de8fa624d5a86c987
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
=======
      backgroundColor: const Color(0xFFF5F5DC),
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: _navBarHeight + _navBarMargin * 2,
      margin: const EdgeInsets.all(_navBarMargin),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/bar.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavButton('assets/icons/dish.png', 0),
                _buildNavButton('assets/icons/spoon.png', 1),
                _buildNavButton('assets/icons/profile.png', 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String iconPath, int index) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: _iconSize + _iconPadding * 2,
        height: _iconSize + _iconPadding * 2,
        padding: const EdgeInsets.all(_iconPadding),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              )
            : null,
        child: Image.asset(
          iconPath,
          width: _iconSize,
          height: _iconSize,
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

class MealsScreen extends StatefulWidget {
  final Function(int calories, double proteins, double fats, double carbs) onMealAdded;
  final String mealType;

  const MealsScreen({
    Key? key,
    required this.onMealAdded,
    required this.mealType,
  }) : super(key: key);

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  String selectedFilter = 'Все';

  final List<Map<String, dynamic>> dishes = [
    {'name': 'Картошка с котлетой', 'calories': 400, 'category': 'Мясное', 'image': 'assets/images/potatoes.png'},
    {'name': 'Борщ', 'calories': 200, 'category': 'Супы', 'image': 'assets/images/borsch.png'},
    {'name': 'Гречка с сарделькой', 'calories': 350, 'category': 'Мясное', 'image': 'assets/images/grechka.png'},
    {'name': 'Пельмени', 'calories': 500, 'category': 'Мясное', 'image': 'assets/images/pelmeni.png'},
    // Add more dishes as needed
  ];

  final List<Map<String, dynamic>> mealPlans = [
    {'title': 'Демократия', 'description': 'Салат с курицей', 'image': 'assets/images/democr.png'},
    {'title': 'Комплекс Отличный', 'description': 'Мясное блюдо с макаронами', 'image': 'assets/images/most.png'},
    {'title': 'Завтрак школьника', 'description': '', 'image': 'assets/images/breackfast.png'},
    // Add more meal plans as needed
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
>>>>>>> 8d9b8489fb21a1c8891ed85de8fa624d5a86c987
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
<<<<<<< HEAD
                    plan: plan['plan'],
=======
>>>>>>> 8d9b8489fb21a1c8891ed85de8fa624d5a86c987
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
<<<<<<< HEAD
=======
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

  MealPlanCard({required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Increased width
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 200, // Increased width
            height: 150, // Increased height
            child: Image.asset(image, width: double.infinity, fit: BoxFit.contain),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat-Medium', color: Colors.black),
            ),
          ),
        ],
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

class DiaryScreen extends StatelessWidget {
  final bool showNavBar;

  const DiaryScreen({Key? key, required this.showNavBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary Screen'),
      ),
      body: Center(
        child: Text('Diary Screen Content'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Center(
        child: Text('Profile Screen Content'),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1CB),
      body: Center(
        child: Text('Menu with meals and meal plans'),
>>>>>>> 8d9b8489fb21a1c8891ed85de8fa624d5a86c987
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