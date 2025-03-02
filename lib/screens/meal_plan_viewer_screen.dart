import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MealPlanViewerScreen extends StatelessWidget {
  final String title;
  final String planImage;

  const MealPlanViewerScreen({
    Key? key,
    required this.title,
    required this.planImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF76B53F),
      ),
      body: PhotoView(
        imageProvider: AssetImage(planImage),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 5, // Increased max zoom
        initialScale: PhotoViewComputedScale.contained,
        backgroundDecoration: const BoxDecoration(
          color: Color(0xFFEAF1CB),
        ),
        enableRotation: false, // Disable rotation for better UX
        basePosition: Alignment.center,
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF76B53F)),
          ),
        ),
        errorBuilder: (context, error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 16),
              Text(
                'Ошибка загрузки изображения',
                style: TextStyle(color: Colors.red[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}