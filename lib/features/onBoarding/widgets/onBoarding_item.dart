import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class OnBoardItem extends StatelessWidget {
  const OnBoardItem({
    super.key,
    required this.description,
    required this.image,
    required this.part1,
    required this.part2,
    required this.part3,
    required this.part4,
  });
  final String part1;
  final String part2;
  final String part3;
  final String part4;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(alignment: Alignment.bottomCenter, children: [
        SvgPicture.asset(
          image,
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width / 1.2,
          fit: BoxFit.fill,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withAlpha(30), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: part1.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: AppColors.darkBlue,
                              fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: part2.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: part3.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: AppColors.darkBlue,
                                  fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: part4.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                    // textAlign: TextAlign.center,
                    // title.tr(),
                    // style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    //     fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
                    ),
                verticalSpace(10),
                Text(
                  textAlign: TextAlign.center,
                  description.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.lightBlue),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
