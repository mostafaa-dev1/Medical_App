import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/theme_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';

class EmptyAppointments extends StatelessWidget {
  const EmptyAppointments({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          ThemeChecker.isDark(context)
              ? 'assets/images/empty-dark.svg'
              : 'assets/images/empty.svg',
          width: 200,
          height: MediaQuery.of(context).size.width / 2,
        ),
        verticalSpace(50),
        Text(
          textAlign: TextAlign.center,
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
