import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';
import 'package:medical_system/features/appointments/logic/appointments_cubit.dart';

class CancelAppointment extends StatelessWidget {
  const CancelAppointment({super.key, required this.appointment});
  final Appointment appointment;

  // final List<String> reasons = [
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentsCubit, AppointmentsState>(
      listener: (context, state) {
        if (state is CancelAppointmentError) {
          showCustomDialog(
              context: context,
              message: state.message,
              title: 'dialog.oops'.tr(),
              onConfirmPressed: () {},
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error);
        } else if (state is CancelAppointmentSuccess) {
          showCustomDialog(
              context: context,
              message: 'appointments.cancelSuccess'.tr(),
              title: 'dialog.sentSuccess'.tr(),
              onConfirmPressed: () {
                context.pop();
                context.pushNamedAndRemoveUntil(
                  AppRoutes.mainScreen,
                );
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.success);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AppointmentsCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'appointments.cancelAppointment'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppPreferances.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'appointments.cancelReason'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                verticalSpace(10),
                ...List.generate(
                  cubit.reasons.length,
                  (index) => Row(
                    children: [
                      Radio(
                        value: index,
                        fillColor: WidgetStateProperty.all(AppColors.mainColor),
                        groupValue: cubit.selectedCancelIndex,
                        activeColor: AppColors.mainColor,
                        onChanged: (value) {
                          cubit.selectCancelIndex(index);
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.selectCancelIndex(index);
                        },
                        child: Text(cubit.reasons[index],
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          withBorderSide: true,
                          paddingHorizental: 5,
                          paddingVirtical: 5,
                          width: 100,
                          backgroundColor: AppColors.lightRed,
                          buttonColor: AppColors.lightRed,
                          buttonName: 'appointments.cancel'.tr(),
                          onPressed: () {
                            context.pop();
                            //cubit.cancelAppointment(context);
                          }),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: CustomButton(
                          isLoading: state is CancelAppointmentLoading,
                          buttonName: 'appointments.submit'.tr(),
                          width: 100,
                          paddingHorizental: 5,
                          paddingVirtical: 5,
                          onPressed: () {
                            cubit.cancelAppointment(
                                cubit.reasons[cubit.selectedCancelIndex],
                                appointment);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// WoltModalSheetPage page1(
//     BuildContext modalSheetContext, ValueNotifier<int> pageIndexNotifier) {
//   return WoltModalSheetPage(
//     hasTopBarLayer: false,
//     backgroundColor: Theme.of(modalSheetContext).colorScheme.primary,
//     child: Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'appointments.cancelAppointment'.tr(),
//             style: Theme.of(modalSheetContext).textTheme.titleLarge!.copyWith(
//                   color: Colors.red,
//                 ),
//           ),
//           verticalSpace(20),
//           Text(
//             textAlign: TextAlign.center,
//             'appointments.cancelAppointmentMessage'.tr(),
//             style: Theme.of(modalSheetContext).textTheme.bodyMedium,
//           ),
//           verticalSpace(100),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomButton(
//                   backgroundColor: AppColors.mainColor.withAlpha(20),
//                   buttonColor: AppColors.mainColor,
//                   buttonName: 'appointments.no'.tr(),
//                   onPressed: () {
//                     Navigator.of(modalSheetContext).pop();
//                     pageIndexNotifier.value = 0;
//                   },
//                   width: MediaQuery.of(modalSheetContext).size.width > 500
//                       ? 200
//                       : 150,
//                   paddingVirtical: 5,
//                   paddingHorizental: 10),
//               horizontalSpace(10),
//               CustomButton(
//                 buttonName: 'appointments.yes'.tr(),
//                 onPressed: () {
//                   pageIndexNotifier.value = pageIndexNotifier.value + 1;
//                 },
//                 width: MediaQuery.of(modalSheetContext).size.width > 500
//                     ? 200
//                     : 150,
//                 paddingVirtical: 5,
//                 paddingHorizental: 10,
//               )
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// WoltModalSheetPage page2(
//     BuildContext modalSheetContext, ValueNotifier<int> pageIndexNotifier) {
//   return WoltModalSheetPage(
//       hasTopBarLayer: false,
//       backgroundColor: Theme.of(modalSheetContext).colorScheme.primary,
//       child: Column(
//         children: [
//           CancelAppointment(),
//           verticalSpace(20),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CustomButton(
//                     backgroundColor: AppColors.mainColor.withAlpha(20),
//                     buttonColor: AppColors.mainColor,
//                     buttonName: 'appointments.cancel'.tr(),
//                     onPressed: () {
//                       Navigator.of(modalSheetContext).pop();
//                       pageIndexNotifier.value = 0;
//                     },
//                     width: MediaQuery.of(modalSheetContext).size.width > 500
//                         ? 200
//                         : 150,
//                     paddingVirtical: 5,
//                     paddingHorizental: 10),
//                 horizontalSpace(10),
//                 CustomButton(
//                   buttonName: 'appointments.submit'.tr(),
//                   onPressed: () {},
//                   width: MediaQuery.of(modalSheetContext).size.width > 500
//                       ? 200
//                       : 150,
//                   paddingVirtical: 5,
//                   paddingHorizental: 10,
//                 )
//               ],
//             ),
//           )
//         ],
//       ));
// }
