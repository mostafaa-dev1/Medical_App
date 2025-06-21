import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/medical_histroy/logic/ai_medical_histroy_cubit.dart';

class MedicalHistroyQuestions extends StatelessWidget {
  const MedicalHistroyQuestions({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiMedicalHistroyCubit, AiMedicalHistroyState>(
      listener: (context, state) {
        if (state is UploadMedicalHistroySuccess) {
          context.pop();
        }
      },
      builder: (context, state) {
        var cubit = context.read<AiMedicalHistroyCubit>();
        return Scaffold(
          persistentFooterButtons: [
            CustomButton(
              buttonName: cubit.questionIndex == cubit.questions.length - 1
                  ? 'medicalReport.finish'.tr()
                  : 'medicalReport.next'.tr(),
              onPressed: () {
                if (cubit.questionIndex < cubit.questions.length - 1) {
                  if (cubit.formKey.currentState!.validate() ||
                      cubit.yesOrno != null) {
                    if (cubit.questions[cubit.questionIndex]['type'] == 'Y&N') {
                      cubit.answer = cubit.yesOrno == 0 ? 'Yes' : 'No';
                      cubit.subAnswer =
                          cubit.subAnswer = cubit.subAnswerController.text;
                    } else {
                      cubit.answer = cubit.answerController.text;
                      cubit.subAnswer = cubit.subAnswerController.text;
                    }

                    cubit.addAnswer();
                  } else {
                    // Handle the case when all questions are answered
                    // For example, you can navigate to a summary page or submit the answers
                  }
                } else {
                  cubit.uploadMedicalHistroy(user.id!);
                }
              },
              isLoading: state is UploadMedicalHistroyLoading,
              width: double.infinity,
              height: 40,
              paddingVirtical: 0,
              paddingHorizental: 10,
            ),
          ],
          appBar: AppBar(
            title: Text(
              'medicalReport.medicalReport'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${'medicalReport.question'.tr()} (${cubit.questionIndex + 1}/${cubit.questions.length})',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Divider(),
                    verticalSpace(20),
                    Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'medicalReport.${cubit.questions[cubit.questionIndex]['question']}'
                                .tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          verticalSpace(10),
                          cubit.questions[cubit.questionIndex]['type'] == "Y&N"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                        withBorderSide:
                                            cubit.yesOrno == 0 ? false : true,
                                        buttonColor: cubit.yesOrno == 0
                                            ? Colors.white
                                            : AppColors.mainColor,
                                        backgroundColor: AppColors.mainColor,
                                        buttonName: 'medicalReport.yes'.tr(),
                                        onPressed: () {
                                          cubit.yesOrnoSwitch(0);
                                        },
                                        width: 120,
                                        height: 35,
                                        paddingVirtical: 0,
                                        paddingHorizental: 10),
                                    horizontalSpace(5),
                                    CustomButton(
                                        withBorderSide:
                                            cubit.yesOrno == 1 ? false : true,
                                        buttonColor: cubit.yesOrno == 1
                                            ? Colors.white
                                            : AppColors.mainColor,
                                        backgroundColor: AppColors.mainColor,
                                        buttonName: 'medicalReport.No'.tr(),
                                        onPressed: () {
                                          cubit.yesOrnoSwitch(1);
                                        },
                                        width: 120,
                                        height: 35,
                                        paddingVirtical: 0,
                                        paddingHorizental: 10),
                                  ],
                                )
                              : CustomTextFrom(
                                  hintText:
                                      'medicalReport.${cubit.questions[cubit.questionIndex]['question']}'
                                          .tr(),
                                  controller: cubit.answerController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'medicalReport.pleaseFill'.tr();
                                    }
                                    return null;
                                  },
                                ),
                          verticalSpace(10),
                          cubit.questions[cubit.questionIndex]['subQuestion'] !=
                                      null &&
                                  cubit.yesOrno == 0
                              ? CustomTextFrom(
                                  hintText:
                                      'medicalReport.${cubit.questions[cubit.questionIndex]['subQuestion']}'
                                          .tr(),
                                  withhint: true,
                                  controller: cubit.subAnswerController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'medicalReport.pleaseFill'.tr();
                                    }
                                    return null;
                                  },
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
