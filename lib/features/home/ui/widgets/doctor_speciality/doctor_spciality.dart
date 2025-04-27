import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/features/home/logic/main_cubit.dart';
import 'package:medical_system/features/home/ui/widgets/doctor_speciality/widgets/specialties_item.dart';
import 'package:medical_system/features/home/ui/widgets/doctor_speciality/widgets/specialties_loading.dart';
import 'package:medical_system/features/home/ui/widgets/home_header_item.dart';

class DoctorSpciality extends StatelessWidget {
  const DoctorSpciality({super.key, required this.user, required this.type});
  final UserModel user;
  final String type;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        var mainCubit = context.watch<MainCubit>();
        final specialities = mainCubit.spcilailties;
        if (state is GetSpcilailtiesLoading ||
            mainCubit.isSpcilailtiesLoading) {
          return SpecialtiesLoading();
        } else {
          if (specialities.spcilailties!.isEmpty ||
              specialities.spcilailties == null) {
            return const SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeaderItem(
                    onPress: () {
                      context.pushNamed(AppRoutes.spcialities,
                          arguments: {'user': user, 'type': type});
                    },
                    title: type == 'Doctor'
                        ? 'home.doctorSpeciality'.tr()
                        : 'home.labsSpecialities'.tr()),
                verticalSpace(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.appWidth(context) > 600 &&
                                Responsive.appWidth(context) < 800
                            ? 5
                            : Responsive.appWidth(context) < 600
                                ? 3
                                : 6,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio:
                            MediaQuery.sizeOf(context).width > 600 ? 1.2 : 1.4,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          type == 'Doctor' && Responsive.appWidth(context) < 500
                              ? 6
                              : specialities.spcilailties!.length,
                      itemBuilder: (context, index) {
                        return SpecialtiesItem(
                          specialities: specialities.spcilailties![index],
                        );
                      }),
                )
              ],
            );
          }
        }
      },
    );
  }
}
