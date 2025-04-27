import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReviewItemLoading extends StatelessWidget {
  const ReviewItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                        ),
                        horizontalSpace(10),
                        Text(
                          'User Name',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.secondaryColor.withAlpha(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.secondaryColor,
                                size: 15,
                              ),
                              horizontalSpace(5),
                              Text(
                                '0.0',
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
                      'This is a loading review item. It will be replaced with actual data once loaded.',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            height: 1.5,
                            color: AppColors.lightBlue,
                          ),
                    ),
                  ],
                ),
              )),
    );
  }
}
