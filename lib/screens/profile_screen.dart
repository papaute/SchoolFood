import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedActivity = 'active';
  bool _hasAllergies = false;
  bool _hasDiabetes = false;
  String _selectedGoal = 'maintain';
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1CB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/profilehead.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField(
                    icon: Icons.calendar_today,
                    label: 'Возраст',
                    keyboardType: TextInputType.number,
                  ),
                  _buildInputField(
                    icon: Icons.height,
                    label: 'Рост (см)',
                    keyboardType: TextInputType.number,
                  ),
                  _buildInputField(
                    icon: Icons.monitor_weight,
                    label: 'Вес (кг)',
                    keyboardType: TextInputType.number,
                  ),
                  _buildGenderSelector(),
                  _buildInputField(
                    icon: Icons.school,
                    label: 'Школа',
                  ),
                  _buildInputField(
                    icon: Icons.class_,
                    label: 'Класс',
                  ),
                  _buildCheckbox(
                    'Аллергии',
                    _hasAllergies,
                    (value) => setState(() => _hasAllergies = value!),
                  ),
                  _buildCheckbox(
                    'Диабет',
                    _hasDiabetes,
                    (value) => setState(() => _hasDiabetes = value!),
                  ),
                  _buildGoalSelector(),
                  const SizedBox(height: 20),
                  _buildActivitySelector(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String label,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(icon, color: const Color(0xFF76B53F)),
          labelText: label,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF76B53F)),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.people, color: const Color(0xFF76B53F)),
          const SizedBox(width: 16),
          Expanded(
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'male', label: Text('Мужской')),
                ButtonSegment(value: 'female', label: Text('Женский')),
              ],
              selected: {_selectedGender},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedGender = newSelection.first;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF76B53F),
    );
  }

  Widget _buildGoalSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Цель:', style: TextStyle(fontSize: 16)),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'lose', label: Text('Сброс')),
            ButtonSegment(value: 'maintain', label: Text('Поддержание')),
            ButtonSegment(value: 'gain', label: Text('Набор')),
          ],
          selected: {_selectedGoal},
          onSelectionChanged: (Set<String> newSelection) {
            setState(() {
              _selectedGoal = newSelection.first;
            });
          },
        ),
      ],
    );
  }

  Widget _buildActivitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Уровень активности:', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActivityButton('low', 'stay.png', 'Малоподвижный'),
            _buildActivityButton('medium', 'walk.png', 'Средняя активность'),
            _buildActivityButton('active', 'run.png', 'Активный'),
          ],
        ),
        if (_selectedActivity == 'active')
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Обычные ежедневные нагрузки и не менее 60 мин. умеренных ежедневных нагрузок',
              style: TextStyle(
                color: Color(0xFF76B53F),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActivityButton(String value, String icon, String label) {
    final isSelected = _selectedActivity == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedActivity = value),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected 
                ? const Color(0xFF76B53F).withOpacity(0.9)  // Lighter when selected
                : const Color(0xFF76B53F).withOpacity(0.2),  // Pale green background when not selected
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/images/$icon',
              width: 40,
              height: 40,
              color: Colors.white,  // Always white icon
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF76B53F) : Colors.black54,
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}