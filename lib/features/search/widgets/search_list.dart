import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/core/widgets/not_found.dart';
import 'package:medical_system/features/search/logic/search_cubit.dart';
import 'package:medical_system/features/search/widgets/search_item.dart';
import 'package:medical_system/features/search/widgets/search_loading.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is LocationError) {
          if (state.message == 'dialog.locationDisabled') {
            showCustomDialog(
              context: context,
              message: state.message.tr(),
              title: 'dialog.oops',
              onConfirmPressed: () {
                context.read<SearchCubit>().openLocationSettings();
                context.pop();
              },
              confirmButtonName: 'dialog.enableLocation'.tr(),
              dialogType: DialogType.warning,
              withTowButtons: true,
              cancelButtonName: 'dialog.cancel'.tr(),
            );
          } else {
            showCustomDialog(
              context: context,
              message: state.message.tr(),
              title: 'dialog.oops',
              onConfirmPressed: () {
                context.pop();
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = context.read<SearchCubit>();
        final doctors = cubit.doctors;
        if (state is SearchLoading) {
          return SearchListLoading();
        } else {
          if (doctors.clinics == null) {
            return Expanded(
              child: Center(
                child: Text('search.startSearch'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!),
              ),
            );
          } else if (doctors.clinics!.isEmpty) {
            return NotFound();
          } else {
            return Expanded(
              child: ListView.builder(
                  itemCount: doctors.clinics!.length,
                  itemBuilder: (context, index) {
                    return SearchItem(
                      user: user,
                      clinic: doctors.clinics![index],
                    );
                  }),
            );
          }
        }
      },
    );
  }
}
