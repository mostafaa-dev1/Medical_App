import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/home/ui/widgets/services/data/models/question_model.dart';
import 'package:medical_system/features/profile/logic/profile_cubit.dart';

class Questionanwsers extends StatelessWidget {
  const Questionanwsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        final questions = cubit.questionModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'profile.myQuestions'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: state is GetQuestionAnswersLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    )
                  : ListView.builder(
                      itemCount: questions!.length,
                      itemBuilder: (context, index) {
                        return questionItem(context, questions, index);
                      },
                    )),
        );
      },
    );
  }

  Container questionItem(
      BuildContext context, List<QuestionModel> questions, int index) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                spreadRadius: 7,
                blurRadius: 3,
                offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parseDate(questions[index].date.toString(), context),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          verticalSpace(5),
          Text(
            questions[index].question,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          verticalSpace(5),
          Text(
            questions[index].questionDetails,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Divider(),
          questions[index].answer == null
              ? Text(
                  'profile.notAnswerd'.tr(),
                  style: Theme.of(context).textTheme.labelSmall,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                questions[index].doctor!.image == null
                                    ? AssetImage('assets/images/user.png')
                                    : NetworkImage(
                                        questions[index].doctor!.image!)),
                        horizontalSpace(10),
                        Text(
                          '${LanguageChecker.isArabic(context) ? questions[index].doctor!.firstNameAr : questions[index].doctor!.firstName} ${LanguageChecker.isArabic(context) ? questions[index].doctor!.lastNameAr : questions[index].doctor!.lastName!}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    verticalSpace(5),
                    Text(
                      '${questions[index].answer}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  String parseDate(String date, BuildContext context) {
    DateTime parsed = DateTime.parse(date);
    // formate 22 MAY 2023 | 11:30 PM
    return DateFormat('dd MMM yyyy | hh:mm a',
            LanguageChecker.isArabic(context) ? 'ar_EG' : 'en_US')
        .format(parsed);
  }
}
