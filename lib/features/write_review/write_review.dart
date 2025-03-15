import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class WriteReview extends StatelessWidget {
  const WriteReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'writeReview.writeReview'.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(
                      color: AppColors.mainColor,
                    )),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: AssetImage('assets/images/doctor.png'),
                      fit: BoxFit.fill,
                    )),
              ),
              verticalSpace(20),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  textAlign: TextAlign.center,
                  '${'writeReview.askForReview'.tr()} Dr. John Doe?',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              verticalSpace(30),
              AnimatedRatingStars(
                initialRating: 3.5,
                minRating: 0.0,
                maxRating: 5.0,
                filledColor: AppColors.mainColor,
                emptyColor: Colors.grey,
                filledIcon: Icons.star,
                halfFilledIcon: Icons.star_half,
                emptyIcon: Icons.star_border,
                onChanged: (double rating) {
                  // Handle the rating change here
                  print('Rating: $rating');
                },
                displayRatingValue: true,
                interactiveTooltips: true,
                customFilledIcon: Icons.star,
                customHalfFilledIcon: Icons.star_half,
                customEmptyIcon: Icons.star_border,
                starSize: 30.0,
                animationDuration: Duration(milliseconds: 300),
                animationCurve: Curves.easeInOut,
                readOnly: false,
              ),
              verticalSpace(30),
              CustomTextFrom(
                maxLines: null,
                withhint: true,
                hintText: 'writeReview.writeReviewHere'.tr(),
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      backgroundColor: AppColors.mainColor.withAlpha(20),
                      buttonColor: AppColors.mainColor,
                      buttonName: 'writeReview.cancel'.tr(),
                      onPressed: () {},
                      width: MediaQuery.of(context).size.width / 2.5,
                      paddingVirtical: 10,
                      paddingHorizental: 10),
                  horizontalSpace(10),
                  CustomButton(
                      buttonName: 'writeReview.submit'.tr(),
                      onPressed: () {},
                      width: MediaQuery.of(context).size.width / 2.5,
                      paddingVirtical: 10,
                      paddingHorizental: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
