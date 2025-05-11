import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/clinics/logic/clinic_cubit.dart';

class ClinicFilterValues extends StatelessWidget {
  const ClinicFilterValues({super.key});

  @override
  Widget build(BuildContext context) {
    var filterValues = context.read<ClinicCubit>().filterValues;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: LanguageChecker.isArabic(context)
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: filterValues['rating'] == null ||
                          filterValues['rating'] == 'All'
                      ? AppColors.mainColor.withAlpha(20)
                      : AppColors.mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                      size: 15,
                    ),
                    horizontalSpace(5),
                    Text(
                        filterValues['rating'] == null ||
                                filterValues['rating'] == 'All'
                            ? 'search.all'.tr()
                            : '${filterValues['rating']}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: filterValues['rating'] == null ||
                                      filterValues['rating'] == 'All'
                                  ? AppColors.mainColor
                                  : Colors.white,
                            )),
                  ],
                ),
              ),
              horizontalSpace(5),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: filterValues['government'] == null ||
                          filterValues['government'] == 'All'
                      ? AppColors.mainColor.withAlpha(20)
                      : AppColors.mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                    filterValues['government'] == null ||
                            filterValues['government'] == 'All'
                        ? 'search.government'.tr()
                        : '${filterValues['government']}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: filterValues['government'] == null ||
                                  filterValues['government'] == 'All'
                              ? AppColors.mainColor
                              : Colors.white,
                        )),
              ),
              horizontalSpace(5),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: filterValues['city'] == null ||
                          filterValues['city'] == 'All'
                      ? AppColors.mainColor.withAlpha(20)
                      : AppColors.mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                    filterValues['city'] == null ||
                            filterValues['city'] == 'All'
                        ? 'search.city'.tr()
                        : '${filterValues['city']}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: filterValues['city'] == null ||
                                  filterValues['city'] == 'All'
                              ? AppColors.mainColor
                              : Colors.white,
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget searchValue(String title,String? value) => Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 3,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.mainColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: AppColors.mainColor,
//         ),
//       ),
//       child: Text(
//           value== null ? title : 'value',
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 color: Colors.white,
//               )),
//     );
