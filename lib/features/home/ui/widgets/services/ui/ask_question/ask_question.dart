import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/custom_dropdown.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/home/ui/widgets/services/logic/services_cubit.dart';

class AskQuestion extends StatelessWidget {
  const AskQuestion({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
        if (state is ServicesError) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              dialogType: DialogType.error,
              message: 'askQuestion.askQuestionError'.tr(),
              onConfirmPressed: () => context.pop(),
              confirmButtonName: 'dialog.ok'.tr(),
              title: 'dialog.oops'.tr(),
            ),
          );
        }
        if (state is ServicesSuccess) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              dialogType: DialogType.sent,
              message: 'askQuestion.askQuestionSuccess'.tr(),
              onConfirmPressed: () => context.pop(),
              title: 'dialog.sentSuccess'.tr(),
              confirmButtonName: 'dialog.ok'.tr(),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<ServicesCubit>();
        return Scaffold(
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- ${'askQuestion.identity'.tr()}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  verticalSpace(5),
                  Text(
                    '- ${'askQuestion.notdiagnosis'.tr()}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  verticalSpace(5),
                  CustomButton(
                    isLoading: state is ServicesLoading,
                    onPressed: () {
                      if (cubit.questionKey.currentState!.validate()) {
                        cubit.sendQuestion(userId);
                      }
                      // context.pushNamed(AppRoutes.patientAppointmentDetails);
                    },
                    buttonName: 'askQuestion.send'.tr(),
                    width: double.infinity,
                    paddingVirtical: 5,
                    height: 40,
                    paddingHorizental: 10,
                  ),
                ],
              ),
            ),
          ],
          appBar: AppBar(
            title: Text(
              'askQuestion.askQuestion'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPreferances.padding),
              child: Form(
                key: cubit.questionKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppCustomDropDown(
                      withSubhint: true,
                      subHintText: 'askQuestion.specialityHint'.tr(),
                      withHint: true,
                      list: ['Dentist', 'Cardiologist', 'Neurologist'],
                      width: double.infinity,
                      height: 50,
                      text: 'askQuestion.speciality'.tr(),
                      hintText: 'askQuestion.selectSpeciality'.tr(),
                      onChanged: (v) {
                        cubit.speciality = v;
                        return null;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'askQuestion.specialityRequired'.tr();
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    CustomTextFrom(
                        withSubhint: true,
                        subHintText: 'askQuestion.questionHint'.tr(),
                        withhint: true,
                        hintText: 'askQuestion.question'.tr(),
                        controller: cubit.questionController,
                        keyboardType: TextInputType.text,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'askQuestion.questionRequired'.tr();
                          }
                          return null;
                        }),
                    verticalSpace(10),
                    CustomTextFrom(
                        withhint: true,
                        withSubhint: true,
                        subHintText: 'askQuestion.questionDetailsHint'.tr(),
                        hintText: 'askQuestion.questionDetails'.tr(),
                        controller: cubit.questionDetailsController,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'askQuestion.questionDetailsRequired'.tr();
                          }
                          return null;
                        }),
                    verticalSpace(10),
                    Text(
                      'askQuestion.patientDetails'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    verticalSpace(5),
                    Text(
                      'askQuestion.patientDetailsHint'.tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    verticalSpace(10),
                    AppCustomDropDown(
                      withHint: true,
                      list: [
                        'askQuestion.male'.tr(),
                        'askQuestion.female'.tr()
                      ],
                      width: double.infinity,
                      height: 50,
                      text: 'askQuestion.gender'.tr(),
                      hintText: 'askQuestion.selectGender'.tr(),
                      onChanged: (v) {
                        cubit.gender = v;
                        return null;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'askQuestion.genderRequired'.tr();
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    CustomTextFrom(
                        withhint: true,
                        hintText: 'askQuestion.age'.tr(),
                        controller: cubit.ageController,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'askQuestion.ageRequired'.tr();
                          }
                          return null;
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
