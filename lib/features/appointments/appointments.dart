import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/appointments/widgets/canceled.dart';
import 'package:medical_system/features/appointments/widgets/completed.dart';
import 'package:medical_system/features/appointments/widgets/upcoming.dart';

class Appointments extends StatelessWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appointments.myAppointments'.tr(),
            style: Theme.of(context).textTheme.titleLarge),
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
            unselectedLabelColor: Colors.grey[400],
            unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
            labelColor: AppColors.mainColor,
            indicatorColor: AppColors.mainColor,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
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
            Completed(),
            Canceled(),
          ],
          onChange: (index) => print(index),
        ),
      ),
    );
  }
}
