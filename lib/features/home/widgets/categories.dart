import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';

class Categories extends StatelessWidget {
  Categories({super.key});

  final List<String> keys = [
    'home.doctors',
    'home.hospitals',
    'home.nurses',
    'home.pharmacies',
    'home.laboratories',
    'home.clinics',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        itemCount: keys.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context2, index) {
          return Container(
            margin: EdgeInsets.only(
              left: LanguageChecker.isArabic(context) ? 0 : 10,
              right: LanguageChecker.isArabic(context) ? 10 : 0,
            ),
            width: 110,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).canvasColor,
                width: 0.5,
              ),
            ),
            child: Center(
              child: Text(
                '# ${keys[index].tr()}',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
