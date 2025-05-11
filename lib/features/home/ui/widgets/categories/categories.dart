import 'package:flutter/material.dart';
import 'package:medical_system/features/home/ui/widgets/categories/widgets/categories_item.dart';

class Categories extends StatelessWidget {
  Categories({super.key});

  final List<String> categories = [
    'home.doctors',
    'home.laboratories',
    'home.clinics',
  ];
  final List<String> images = [
    'assets/images/categories/doctor.png',
    'assets/images/categories/labs.png',
    'assets/images/categories/clinic.png',
  ];
  // 'home.nurses',
  // 'home.pharmacies',
  // 'home.clinics',

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context2, index) {
          return CategoriesItem(
              index: index, categories: categories, image: images[index]);
        },
      ),
    );
  }
}
