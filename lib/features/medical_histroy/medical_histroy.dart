import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/appointments/ui/widgets/empty_appointments.dart';
import 'package:medical_system/features/main/logic/main_cubit.dart';
import 'package:medical_system/features/medical_histroy/logic/ai_medical_histroy_cubit.dart';

class MedicalHistroy extends StatelessWidget {
  const MedicalHistroy({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiMedicalHistroyCubit, AiMedicalHistroyState>(
      builder: (context, state) {
        var cubit = context.read<AiMedicalHistroyCubit>();
        print(cubit.answers);
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 30,
            leading: Padding(
              padding: EdgeInsets.only(
                  left: LanguageChecker.isArabic(context) ? 0 : 10,
                  right: LanguageChecker.isArabic(context) ? 10 : 0),
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                width: 20,
                height: 15,
              ),
            ),
            title: Text(
              'medicalReport.medicalReport'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppPreferances.padding),
            child: state is GetMedicalHistoryLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  )
                : cubit.answers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EmptyAppointments(
                                title: 'medicalReport.noReport'.tr()),
                            TextButton(
                                onPressed: () {
                                  context.pushNamed(AppRoutes.histroyQuestions,
                                      arguments: {
                                        'context': context,
                                        'user': context.read<MainCubit>().user
                                      });
                                },
                                child: Text(
                                  'medicalReport.create'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: AppColors.secondaryColor),
                                ))
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: MedicalInfoItem(
                                title: 'medicalReport.height'.tr(),
                                value: cubit.answers[0]['height'],
                              )),
                              horizontalSpace(10),
                              Expanded(
                                  child: MedicalInfoItem(
                                title: 'medicalReport.weight'.tr(),
                                value: cubit.answers[1]['weight'],
                              )),
                            ],
                          ),
                          verticalSpace(10),
                          Text(
                            'medicalReport.medicalReport'.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          verticalSpace(10),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: cubit.answers.length - 2,
                                  itemBuilder: (context, index) {
                                    index = index + 2;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .shadow,
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${cubit.answers[index]['question']}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  Text(
                                                    '${cubit.answers[index]['subAnswer']}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.mainColor
                                                    .withAlpha(20),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                  '${cubit.answers[index]['answer']}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }))
                        ],
                      ),
          ),
        );
      },
    );
  }
}

class MedicalInfoItem extends StatelessWidget {
  const MedicalInfoItem({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.mainColor),
            ),
          ),
        ],
      ),
    );
  }
}
