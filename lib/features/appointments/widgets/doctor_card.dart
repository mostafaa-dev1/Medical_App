import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
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
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 60),
          padding: const EdgeInsets.only(left: 60, right: 10),
          height: withButtons ? 120 : 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(
              width: 0.5,
              color: AppColors.mainColor,
            ),
          ),
          child: Column(
            textDirection: ui.TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dr. John Doe',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Brain and Nerves doctor',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              verticalSpace(5),
              Row(
                textDirection: ui.TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(
                            IconBroken.Time_Circle,
                            size: 15,
                          )),
                          TextSpan(
                            text: ' 5 Feb 2023 | 3:00 PM',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )),
                  withTrailingIcon ?? true ? Spacer() : SizedBox(),
                  withTrailingIcon ?? true
                      ? Icon(
                          IconBroken.Chat,
                          color: AppColors.mainColor,
                        )
                      : SizedBox()
                ],
              ),
              verticalSpace(10),
              withButtons
                  ? Row(
                      textDirection: ui.TextDirection.ltr,
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
        ),
        Positioned(
          left: -50,
          child: Container(
            margin: const EdgeInsets.only(left: 60),
            height: withButtons ? 110 : 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).colorScheme.primary,
                border: Border.all(
                  width: 0.5,
                  color: AppColors.mainColor,
                )),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  image: AssetImage('assets/images/doctor.png'),
                  fit: BoxFit.fill,
                )),
          ),
        ),
      ],
    );
  }
}
