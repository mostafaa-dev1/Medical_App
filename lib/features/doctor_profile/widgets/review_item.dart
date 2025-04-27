import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/reviews.dart';
import 'package:medical_system/core/themes/colors.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(color: AppColors.mainColor.withAlpha(20)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Theme.of(context).colorScheme.shadow,
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage:
                    review.user.image == null || review.user.image!.isEmpty
                        ? AssetImage('assets/images/user.png')
                        : NetworkImage(
                            review.user.image!,
                          ),
              ),
              horizontalSpace(10),
              Text(
                '${review.user.firstName} ${review.user.lastName}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: AppColors.mainColor.withAlpha(20),

                  //border: Border.all(color: AppColors.secondaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.secondaryColor,
                      size: 15,
                    ),
                    horizontalSpace(5),
                    Text(
                      review.rate.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              )
            ],
          ),
          verticalSpace(10),
          Text(
            review.review,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  height: 1.5,
                  color: AppColors.lightBlue,
                ),
          ),
        ],
      ),
    );
  }
}
