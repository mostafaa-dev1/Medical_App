import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/test2.dart';

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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Container(
              margin: EdgeInsets.only(
                left: LanguageChecker.isArabic(context) ? 0 : 10,
                right: LanguageChecker.isArabic(context) ? 10 : 0,
              ),
              width: 115,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: AppColors.mainColor.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
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
            ),
          );
        },
      ),
    );
  }
}
