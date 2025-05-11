import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/write_review/logic/write_review_cubit.dart';

class WriteReview extends StatelessWidget {
  const WriteReview({super.key, required this.user, required this.appointment});

  final Appointment appointment;
  final UserModel user;

  String getName(BuildContext context) {
    if (appointment.clinic != null) {
      if (LanguageChecker.isArabic(context)) {
        return '${'appointments.dr'.tr()} ${appointment.clinic!.doctor!.firstNameAr} ${appointment.clinic!.doctor!.lastNameAr}';
      } else {
        return '${'appointments.dr'.tr()} ${appointment.clinic!.doctor!.firstName} ${appointment.clinic!.doctor!.lastName}';
      }
    } else if (appointment.hospital != null) {
      if (LanguageChecker.isArabic(context)) {
        return appointment.hospital!.clinic!.nameAr;
      } else {
        return appointment.hospital!.clinic!.name;
      }
    } else if (appointment.lab != null) {
      if (LanguageChecker.isArabic(context)) {
        return appointment.lab!.lab!.nameAr!;
      } else {
        return appointment.lab!.lab!.name!;
      }
    } else {
      return 'Unknown';
    }
  }

  ImageProvider getImage() {
    if (appointment.clinic!.doctor!.image != null) {
      return CachedNetworkImageProvider(appointment
          .clinic!.doctor!.image!); // appointment.clinic!.doctor!.image!;
    } else if (appointment.hospital!.clinic!.image != '') {
      return CachedNetworkImageProvider(appointment.hospital!.clinic!.image);
    } else if (appointment.lab!.lab!.image != null) {
      return CachedNetworkImageProvider(appointment.lab!.lab!.image!);
    }
    return const AssetImage('assets/images/user.png');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteReviewCubit, WriteReviewState>(
      listener: (context, state) {
        if (state is WriteReviewError) {
          showCustomDialog(
              context: context,
              message: 'dialog.reviewError'.tr(),
              title: 'dialog.oops'.tr(),
              onConfirmPressed: () => context.pop(),
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error);
        } else if (state is WriteReviewSuccess) {
          showCustomDialog(
              context: context,
              message: 'writeReview.reviewSent'.tr(),
              title: 'dialog.sentSuccess'.tr(),
              onConfirmPressed: () {
                context.pop();
                context.pop();
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.success);
        }
      },
      builder: (context, state) {
        var writeReviewCubit = context.read<WriteReviewCubit>();

        return Scaffold(
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    backgroundColor: AppColors.mainColor.withAlpha(20),
                    buttonColor: AppColors.mainColor,
                    buttonName: 'writeReview.cancel'.tr(),
                    onPressed: () {
                      context.pop();
                    },
                    width: MediaQuery.of(context).size.width / 2.5,
                    paddingVirtical: 10,
                    paddingHorizental: 10),
                horizontalSpace(10),
                CustomButton(
                    isLoading: state is WriteReviewLoading,
                    buttonName: 'writeReview.submit'.tr(),
                    onPressed: () {
                      if (writeReviewCubit.formKey.currentState!.validate() &&
                          writeReviewCubit.userRate != 0.0) {
                        writeReviewCubit.getClinicRate(
                          clinicId: appointment.clinic!.id!,
                          doctorId: appointment.clinic!.doctor!.id!,
                          userId: user.id!,
                        );
                      }
                    },
                    width: MediaQuery.of(context).size.width / 2.5,
                    paddingVirtical: 10,
                    paddingHorizental: 10),
              ],
            ),
          ],
          appBar: AppBar(
            title: Text(
              'writeReview.writeReview'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppPreferances.padding),
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: writeReviewCubit.formKey,
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
                              image: getImage(),
                              fit: BoxFit.cover,
                            ),
                          )),
                      verticalSpace(20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          textAlign: TextAlign.center,
                          '${'writeReview.askForReview'.tr()} ${getName(context)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      verticalSpace(30),
                      AnimatedRatingStars(
                        initialRating: 0.0,
                        minRating: 0.0,
                        maxRating: 5.0,
                        filledColor: AppColors.mainColor,
                        emptyColor: Colors.grey,
                        filledIcon: Icons.star,
                        halfFilledIcon: Icons.star_half,
                        emptyIcon: Icons.star_border,
                        onChanged: (double rating) {
                          writeReviewCubit.userRate = rating;
                          print('Rating: ${writeReviewCubit.userRate}');
                          // Handle the rating change here
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
                        controller: writeReviewCubit.reviewController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'writeReview.reviewRequired'.tr();
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
