import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/appointments/logic/appointments_cubit.dart';
import 'package:medical_system/features/appointments/ui/widgets/canceled.dart';
import 'package:medical_system/features/appointments/ui/widgets/completed.dart';
import 'package:medical_system/features/appointments/ui/widgets/upcoming.dart';

class Appointments extends StatelessWidget {
  const Appointments({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AppointmentsCubit>();
    return BlocListener<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          if (state is GetAppointmentsError) {
            showDialog(
                context: context,
                builder: (context) => CustomDialog(
                      dialogType: DialogType.error,
                      message: state.message.tr(),
                      onConfirmPressed: () => context.pop(),
                      confirmButtonName: 'dialog.ok'.tr(),
                      title: 'dialog.oops'.tr(),
                    ));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 30,
            leading: Padding(
              padding: EdgeInsets.only(
                  left: LanguageChecker.isArabic(context) ? 0 : 10,
                  right: LanguageChecker.isArabic(context) ? 10 : 0),
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                width: 20,
                height: 15,
              ),
            ),
            title: Text('appointments.myAppointments'.tr(),
                style: Theme.of(context).textTheme.titleSmall),
          ),
          body: Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            height: double.infinity,
            child: ContainedTabBarView(
              tabBarViewProperties: TabBarViewProperties(
                dragStartBehavior: DragStartBehavior.start,
                physics: const BouncingScrollPhysics(),
              ),
              tabBarProperties: TabBarProperties(
                unselectedLabelColor: Colors.grey[300],
                unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
                labelColor: AppColors.mainColor,
                indicatorColor: AppColors.mainColor,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              tabs: [
                Text(
                  'appointments.upcoming'.tr(),
                ),
                Text(
                  'appointments.completed'.tr(),
                ),
                Text(
                  'appointments.canceled'.tr(),
                ),
              ],
              views: [
                Upcoming(),
                Completed(
                  user: user,
                ),
                Canceled(),
              ],
              onChange: (index) {
                if (index == 1 && cubit.completedVisits.appointments == null) {
                  context.read<AppointmentsCubit>().getAppointments(
                      eqKey2: 'type',
                      eqValue2: 'Completed',
                      index: index,
                      patientId: user.id!);
                }
                if (index == 2 && cubit.canceledVisits.appointments == null) {
                  context.read<AppointmentsCubit>().getAppointments(
                      eqKey2: 'type',
                      eqValue2: 'Canceled',
                      index: index,
                      patientId: user.id!);
                }
              },
            ),
          ),
        ));
  }
}
