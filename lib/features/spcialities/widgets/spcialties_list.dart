import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/features/home/ui/widgets/doctor_speciality/widgets/specialties_loading.dart';
import 'package:medical_system/features/spcialities/logic/spcialities_cubit.dart';
import 'package:medical_system/features/spcialities/widgets/spcialities_item.dart';

class SpecialtiesList extends StatelessWidget {
  const SpecialtiesList({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpcialtiesCubit, SpcialtiesState>(
        builder: (context, state) {
      final specialities = context.read<SpcialtiesCubit>().specialities;
      if (state is GetSpecialitiesLoading) {
        return SpecialtiesLoading();
      } else {
        if (specialities.spcilailties == null ||
            specialities.spcilailties!.isEmpty) {
          return const SizedBox();
        } else {
          return Expanded(
            child: GridView.builder(
              itemCount: specialities.spcilailties!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: MediaQuery.sizeOf(context).width > 600 &&
                        MediaQuery.sizeOf(context).width < 700
                    ? 5
                    : MediaQuery.sizeOf(context).width > 700
                        ? 6
                        : 3,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return SpcialitiesItem(
                  user: user,
                  specialities: specialities.spcilailties![index],
                );
              },
            ),
          );
        }
      }
    });
  }
}
