import 'package:flutter/material.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TimesLoading extends StatelessWidget {
  const TimesLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.appWidth(context) > 600 &&
                  Responsive.appWidth(context) < 800
              ? 5
              : Responsive.appWidth(context) < 600
                  ? 3
                  : 6,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 2.9,
        ),
        itemCount: 12,
        itemBuilder: (context, index) => Container(
          width: 110,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.mainColor.withAlpha(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('time',

                  // available times
                  style: Theme.of(context).textTheme.bodySmall!),
            ],
          ),
        ),
      ),
    );
  }
}
