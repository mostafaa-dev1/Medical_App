import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/book_appointment/select_date_time/logic/date_time_cubit.dart';
import 'package:medical_system/features/book_appointment/select_date_time/widgets/times_loading.dart';

class Times extends StatelessWidget {
  const Times({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        var bookAppointmentCubit = context.read<DateTimeCubit>();

        if (state is GetAvailableTimesLoading) {
          return const Center(
            child: TimesLoading(),
          );
        } else {
          if (bookAppointmentCubit.times.isEmpty) {
            return Center(
              child: Text('appointments.selectDate'.tr(),
                  style: Theme.of(context).textTheme.bodySmall),
            );
          } else {
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
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 2.9,
              ),
              itemCount: bookAppointmentCubit.times.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  bookAppointmentCubit.selectTime(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 110,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: bookAppointmentCubit.selectedTime == index
                          ? AppColors.mainColor
                          : AppColors.mainColor.withAlpha(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Format.formatTime(
                            DateTime(
                                0,
                                0,
                                0,
                                int.parse(
                                    bookAppointmentCubit.times[index]['hour']!),
                                int.parse(bookAppointmentCubit.times[index]
                                    ['minute']!)),
                            context), // available times
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: bookAppointmentCubit.selectedTime == index
                                  ? Colors.white
                                  : AppColors.mainColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
