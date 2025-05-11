import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/widgets/not_found.dart';
import 'package:medical_system/features/clinics/data/model/clinic_model.dart';
import 'package:medical_system/features/clinics/logic/clinic_cubit.dart';
import 'package:medical_system/features/clinics/widgets/clinic_Item.dart';
import 'package:medical_system/features/clinics/widgets/clinic_profile/widgets/clinic_specialities.dart';
import 'package:medical_system/features/clinics/widgets/clinic_profile/widgets/doctor_clinic_item.dart';
import 'package:medical_system/features/clinics/widgets/clinic_profile/widgets/doctor_clinic_item_loading.dart';

class ClinicProfile extends StatelessWidget {
  const ClinicProfile({super.key, required this.clinic, required this.user});
  final ClinicInfo clinic;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicCubit, ClinicState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = context.read<ClinicCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LanguageChecker.isArabic(context)
                  ? clinic.clinic!.nameAr
                  : clinic.clinic!.name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Column(children: [
            ClinicItem(
              clinic: clinic,
              user: user,
            ),
            verticalSpace(10),
            ClinicSpecialities(clinicId: clinic.id.toString()),
            verticalSpace(10),
            state is FitchDoctorsLoading
                ? DoctorClinicItemLoading()
                : cubit.doctors == null
                    ? Center(
                        child: Text(
                          'appointments.selectSpeciality'.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    : cubit.doctors!.isEmpty
                        ? Expanded(child: NotFound())
                        : Expanded(
                            child: ListView.builder(
                              itemCount: cubit.doctors!.length,
                              itemBuilder: (context, index) => DoctorClinicItem(
                                doctor: cubit.doctors![index],
                                clinic: clinic,
                                user: user,
                              ),
                            ),
                          ),
          ]),
        );
      },
    );
  }
}
