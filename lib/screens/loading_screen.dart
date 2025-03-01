import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(), // Navigate to MainScreen after loading
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Скрываем системную панель навигации
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual, 
      overlays: [SystemUiOverlay.top]
    );

   return Scaffold(
  body: Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/load_screen.png'),
        fit: BoxFit.cover, // Растягиваем изображение на весь экран
      ),
    ),
    child: Align(
      alignment: Alignment.bottomCenter, // Выравниваем содержимое внизу по центру
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50), // Отступ снизу
        child: Column(
          mainAxisSize: MainAxisSize.min, // Минимальный размер Column
          children: [
            // Первая строка текста
            const Text(
              'Здоровое питание –',
              style: TextStyle(
                fontFamily: 'Moncerrat',
                fontSize: 32,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Выравнивание текста по центру
            ),

            // Вторая строка текста
            const Text(
              'путь к отличным\nзнаниям!',
              style: TextStyle(
                fontFamily: 'Moncerrat',
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Выравнивание текста по центру
            ),
          ],
        ),
      ),
    ),
  ),
);
  }

  @override
  void dispose() {
    // Возвращаем системную панель навигации при закрытии экрана
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual, 
      overlays: SystemUiOverlay.values
    );
    super.dispose();
  }
}