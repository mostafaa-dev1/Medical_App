import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/widgets/doctor_card_button.dart';
import 'package:medical_system/core/widgets/doctor_card_oulined_button.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard(
      {super.key,
      this.onTap1,
      this.onTap2,
      this.butttonName1,
      this.butttonName2,
      this.color,
      this.color2,
      this.withTrailingIcon,
      required this.withButtons});
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;
  final String? butttonName1;
  final String? butttonName2;
  final Color? color;
  final Color? color2;
  final bool withButtons;
  final bool? withTrailingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: withButtons ? 140 : 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        textDirection: ui.TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              textDirection: ui.TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage(
                      'assets/images/doctor.png',
                    ),
                    fit: BoxFit.fill,
                    width: 35,
                    height: 40,
                  ),
                ),
                horizontalSpace(10),
                Column(
                  textDirection: ui.TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dr. Mohamed Ali',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text('Cardiologist',
                        style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
                Spacer(),
                Icon(
                  IconBroken.Location,
                  size: 25,
                )
              ]),
          verticalSpace(10),
          Row(
            children: [
              Icon(
                IconBroken.Time_Circle,
                size: 15,
              ),
              horizontalSpace(5),
              Text('05 Feb 2025, 10:00 PM',
                  style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
          verticalSpace(20),
          withButtons
              ? Row(
                  textDirection: ui.TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onDoubleTap: onTap1,
                      child: DoctorCardOulinedButton(
                        withIcon: false,
                        buttonName: butttonName1 ?? '',
                        borderColor: color,
                      ),
                    ),
                    horizontalSpace(10),
                    GestureDetector(
                        onDoubleTap: onTap2,
                        child: DoctorCardButton(
                            buttonName: butttonName2 ?? '', color: color2)),
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
