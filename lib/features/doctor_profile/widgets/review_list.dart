import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/doctor_profile/logic/doctor_profile_cubit.dart';
import 'package:medical_system/features/doctor_profile/widgets/review_item.dart';
import 'package:medical_system/features/doctor_profile/widgets/review_item_loading.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key, required this.doctorId});
  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        var reviews = context.watch<DoctorProfileCubit>().reviews;
        if (state is GetReviewsLoading) {
          return const ReviewItemLoading();
        } else {
          if (reviews.reviews == null || reviews.reviews!.isEmpty) {
            return Center(
              child: Text('writeReview.noReviews'.tr(),
                  style: Theme.of(context).textTheme.bodySmall),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'doctorProfile.reviews'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.reviews, arguments: {
                            'doctorId': doctorId,
                            'context': context,
                          });
                        },
                        child: Text(
                          'doctorProfile.seeAll'.tr(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    height: 1.5,
                                    color: AppColors.secondaryColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(10),
                ListView.builder(
                  itemBuilder: (context, index) =>
                      ReviewItem(review: reviews.reviews![index]),
                  itemCount: reviews.reviews!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
