import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/not_found.dart';
import 'package:medical_system/features/profile/logic/profile_cubit.dart';
import 'package:medical_system/features/profile/widgets/labResult/data/model/lab_result_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LabResult extends StatelessWidget {
  const LabResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        var results = cubit.results;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'profile.lapResult'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: state is GetLapResultsLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : results!.isEmpty
                    ? NotFound()
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          return resultItem(context, results, index);
                        },
                      ),
          ),
        );
      },
    );
  }

  Container resultItem(
      BuildContext context, List<LabResultModel> results, int index) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 3,
                spreadRadius: 7,
                offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parseDate(results[index].date.toString(), context),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          verticalSpace(5),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.mainColor,
                    )),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: results[index].labModel!.lab!.image == null
                        ? Image.asset(
                            'assets/images/user.png',
                            height: 40,
                          )
                        : Image.network(
                            results[index].labModel!.lab!.image!,
                            height: 40,
                          )),
              ),
              horizontalSpace(5),
              Text(
                LanguageChecker.isArabic(context)
                    ? results[index].labModel!.lab!.nameAr!
                    : results[index].labModel!.lab!.name!,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              openPdfExternally(results[index].result!);
            },
            child: Row(
              children: [
                Icon(
                  IconBroken.Document,
                ),
                horizontalSpace(5),
                Text(
                  'profile.showResult'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                horizontalSpace(5),
                Icon(IconBroken.Arrow___Right_2)
              ],
            ),
          )
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

Future<void> openPdfExternally(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}
