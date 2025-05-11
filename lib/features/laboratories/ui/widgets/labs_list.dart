import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/core/widgets/not_found.dart';
import 'package:medical_system/features/laboratories/logic/laboratories_cubit.dart';
import 'package:medical_system/features/laboratories/ui/widgets/lab_item.dart';
import 'package:medical_system/features/laboratories/ui/widgets/lab_loading.dart';

class LabsList extends StatelessWidget {
  const LabsList({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LaboratoriesCubit, LaboratoriesState>(
      listener: (context, state) {
        if (state is LaboratoriesError) {
          showCustomDialog(
              context: context,
              message: state.errMessage,
              title: 'dialog.oops',
              onConfirmPressed: () {
                context.pop();
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error);
        }
      },
      builder: (context, state) {
        var cubit = context.read<LaboratoriesCubit>();
        final labs = cubit.labs;
        if (state is LaboratoriesLoading) {
          return LabLoading();
        } else {
          if (labs == null) {
            return Expanded(
                child: Center(
              child: Text(
                'search.startSearch'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ));
          } else if (labs.isEmpty) {
            return Expanded(child: NotFound());
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: labs.length,
                itemBuilder: (context, index) {
                  return LabItem(
                    lab: labs[index],
                    user: user,
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
