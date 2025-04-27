import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/doctor_profile/logic/doctor_profile_cubit.dart';
import 'package:medical_system/features/doctor_profile/widgets/review_item_loading.dart';
import 'package:medical_system/features/reviews/widgets/raring_filter.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorProfileCubit, DoctorProfileState>(
      listener: (context, state) {
        if (state is GetReviewsError) {
          showCustomDialog(
              context: context,
              message: state.error,
              title: 'dialog.oops'.tr(),
              onConfirmPressed: () {
                context.pop();
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error);
        }
      },
      builder: (context, state) {
        var reviews = context.read<DoctorProfileCubit>().reviews;
        return Scaffold(
            appBar: AppBar(
              title: Text(
                '4.9 (${5} reviews)',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            body: state is GetReviewsLoading
                ? Padding(
                    padding: const EdgeInsets.all(AppPreferances.padding),
                    child: const ReviewItemLoading(),
                  )
                : reviews.reviews == null || reviews.reviews!.isEmpty
                    ? Center(
                        child: Text('doctorProfile.noReviews'.tr(),
                            style: Theme.of(context).textTheme.bodySmall),
                      )
                    : Column(
                        children: [
                          RatingFilter(),
                          verticalSpace(20),
                          Expanded(
                            child: ListView.builder(
                              itemCount: reviews.reviews!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              AppColors.mainColor.withAlpha(10),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 18,
                                            backgroundImage: reviews
                                                            .reviews![index]
                                                            .user
                                                            .image !=
                                                        null &&
                                                    reviews.reviews![index].user
                                                            .image !=
                                                        ''
                                                ? CachedNetworkImageProvider(
                                                    reviews.reviews![index].user
                                                        .image!)
                                                : AssetImage(
                                                    'assets/images/user.png'),
                                          ),
                                          horizontalSpace(10),
                                          Text(
                                            '${reviews.reviews![index].user.firstName} ${reviews.reviews![index].user.lastName}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Spacer(),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.mainColor
                                                  .withAlpha(20),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.mainColor,
                                                  size: 18,
                                                ),
                                                horizontalSpace(5),
                                                Text(
                                                  Format.formatNumber(
                                                      reviews
                                                          .reviews![index].rate,
                                                      context),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      verticalSpace(10),
                                      Text(
                                        reviews.reviews![index].review,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      verticalSpace(10),
                                      Text(
                                        Format.formatDate(
                                            reviews.reviews![index].date,
                                            context),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ));
      },
    );
  }
}
