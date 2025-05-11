import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/features/main/logic/main_cubit.dart';
import 'package:medical_system/features/home/ui/widgets/home_header_item.dart';
import 'package:medical_system/features/home/ui/widgets/upcoming_visits/widgets/upcoming_item.dart';
import 'package:medical_system/features/home/ui/widgets/upcoming_visits/widgets/upcoming_item_loading.dart';

class UpcomingVisits extends StatelessWidget {
  const UpcomingVisits({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        var mainCubit = context.read<MainCubit>();
        final upcomingVisits = context.read<MainCubit>().upcomingVisits;
        if (mainCubit.isUpcomingLoading ||
            state is GetUpcomingAppointmentsLoading) {
          print('state is HomeLoading || state is PersonalInfoSuccess');
          return UpcomingItemLoading();
        } else {
          if (upcomingVisits.appointments!.isEmpty ||
              upcomingVisits.appointments == null) {
            print('upcomingVisits.appointments!.isEmpty');
            return const SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeaderItem(
                  onPress: () {
                    context.read<MainCubit>().changePageIndex(1);
                  },
                  title: 'home.upcomingVisits'.tr(),
                ),
                verticalSpace(10),
                SizedBox(
                  height: Responsive.appWidth(context) > 600 ? 140 : 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: upcomingVisits.appointments!.length,
                    itemBuilder: (context, index) => UpcomingItem(
                      index: index,
                      model: upcomingVisits.appointments![index],
                    ),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
