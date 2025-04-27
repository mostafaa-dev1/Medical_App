import 'package:flutter/widgets.dart';
import 'package:medical_system/core/themes/colors.dart';

class Suggestions extends StatelessWidget {
  Suggestions({super.key});
  final List<String> searchList = [
    'Dentist',
    'Cardiologist',
    'Surgeon',
    'Neurologist',
    'Orthopedic Surgeon',
    'Gynecologist',
    'Pediatrician',
    'Dermatologist',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(
        searchList.length,
        (index) => Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.secondaryColor.withAlpha(20),
            border: Border.all(
              color: AppColors.secondaryColor.withAlpha(50),
            ),
          ),
          child: Text(
            searchList[index],
            style: TextStyle(color: AppColors.secondaryColor),
          ),
        ),
      ),
    );
  }
}
