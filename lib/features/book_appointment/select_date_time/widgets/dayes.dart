import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/book_appointment/select_date_time/logic/date_time_cubit.dart';

class Dayes extends StatelessWidget {
  const Dayes(
      {super.key,
      required this.workTimes,
      required this.eqvalue,
      required this.eqkey});
  final WorkTimes workTimes;
  final String eqvalue;
  final String eqkey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        var bookAppointmentCubit = context.read<DateTimeCubit>();
        var availableDays = bookAppointmentCubit.availableDays;
        return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.appWidth(context) > 600 &&
                      Responsive.appWidth(context) < 800
                  ? 5
                  : Responsive.appWidth(context) < 600
                      ? 3
                      : 6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.4,
            ),
            itemCount: availableDays.length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    bookAppointmentCubit
                        .selectDay(index); // _selectedDate = DateTime(
                    //   availableDays
                    //   availableDays[index]['dayNumber']!,
                    // )

                    bookAppointmentCubit.calculateTime(
                        workTimes.workTimes![index].start!,
                        workTimes.workTimes![index].end!,
                        int.parse(workTimes.workTimes![index].duration!),
                        eqvalue,
                        eqkey);
                    // _selectedDate = DateTime(
                    //     DateTime.now().year,

                    //     )
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: bookAppointmentCubit.selectedDay == index
                          ? AppColors.mainColor
                          : AppColors.mainColor.withAlpha(20),
                    ),
                    width: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'appointments.${availableDays[index]['dayName']}'
                              .tr(), // Day names
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: bookAppointmentCubit.selectedDay == index
                                    ? Colors.white
                                    : AppColors.mainColor,
                              ),
                        ),
                        Text(
                          availableDays[index]['dayNumber']!, // Day numbers
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: bookAppointmentCubit.selectedDay == index
                                    ? Colors.white
                                    : AppColors.mainColor,
                              ),
                        ),
                        Text(
                          'appointments.${availableDays[index]['monthName']}'
                              .tr(), // Month names
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: bookAppointmentCubit.selectedDay == index
                                    ? Colors.white
                                    : AppColors.mainColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ));
      },
    );
  }
}
