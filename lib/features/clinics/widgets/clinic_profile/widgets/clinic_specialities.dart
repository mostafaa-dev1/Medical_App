import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/specialities.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/clinics/logic/clinic_cubit.dart';

class ClinicSpecialities extends StatelessWidget {
  const ClinicSpecialities({super.key, required this.clinicId});
  final String clinicId;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ClinicCubit>();
    print(cubit.selectedIndex);
    return SizedBox(
        height: 30,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Specialities.list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  cubit.getDoctors(
                      Specialities.specialities[index], clinicId, index);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: index == cubit.selectedIndex
                        ? AppColors.mainColor
                        : AppColors.mainColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(Specialities.list[index].tr(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: index == cubit.selectedIndex
                                  ? Colors.white
                                  : AppColors.mainColor,
                            )),
                  ),
                ),
              );
            }));
  }
}
