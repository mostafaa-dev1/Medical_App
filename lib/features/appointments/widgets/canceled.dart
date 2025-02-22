import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/theme_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/features/appointments/widgets/doctor_card.dart';

class Canceled extends StatelessWidget {
  const Canceled({super.key});
  final bool empty = true;
  @override
  Widget build(BuildContext context) {
    return empty
        ? Column(
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
                'You don’t have an appointment yet',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              verticalSpace(10),
              Text(
                textAlign: TextAlign.center,
                'You don’t have a doctor’s appointment scheduled of the moment',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          )
        : ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DoctorCard(
                    withButtons: false,
                    withTrailingIcon: false,
                  ));
            });
  }
}
