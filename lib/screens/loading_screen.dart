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
    _startLoadingAnimation();
  }

  void _startLoadingAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
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
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Column
           ( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Здоровое питание –',
                style: TextStyle(
                  fontFamily: 'Moncerrat',
                  fontSize: 32,
                  color: Color.fromARGB(255, 255, 255, 255),

                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'путь к отличным\nзнаниям!',
                style: TextStyle(
                  fontFamily:'Moncerrat',
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
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