import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/core/widgets/not_found.dart';
import 'package:medical_system/features/clinics/logic/clinic_cubit.dart';
import 'package:medical_system/features/clinics/widgets/clinic_Item.dart';
import 'package:medical_system/features/clinics/widgets/clinic_loading.dart';

class ClinicsList extends StatelessWidget {
  const ClinicsList({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClinicCubit, ClinicState>(
      listener: (context, state) {
        if (state is LocationError) {
          if (state.errMessage == 'dialog.locationDisabled') {
            showCustomDialog(
              context: context,
              message: state.errMessage.tr(),
              title: 'dialog.oops',
              onConfirmPressed: () {
                context.read<ClinicCubit>().openLocationSettings();
                context.pop();
              },
              confirmButtonName: 'dialog.enableLocation',
              dialogType: DialogType.warning,
              withTowButtons: true,
              cancelButtonName: 'dialog.cancel',
            );
          } else {
            showCustomDialog(
              context: context,
              message: state.errMessage.tr(),
              title: 'dialog.oops',
              onConfirmPressed: () {
                context.pop();
              },
              confirmButtonName: 'dialog.ok',
              dialogType: DialogType.warning,
              withTowButtons: true,
              cancelButtonName: 'dialog.cancel',
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = context.read<ClinicCubit>();
        final clinics = cubit.clinics;
        if (state is ClinicLoading) {
          return ClinicsLoading();
        } else {
          if (clinics == null || clinics.isEmpty) {
            return const Center(child: NotFound());
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: clinics.length,
                itemBuilder: (context, index) {
                  return ClinicItem(clinic: clinics[index], user: user);
                },
              ),
            );
          }
        }
      },
    );
  }
}
