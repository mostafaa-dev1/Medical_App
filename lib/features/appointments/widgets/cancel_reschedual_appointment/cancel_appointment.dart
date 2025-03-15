import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class CancelAppointment extends StatefulWidget {
  const CancelAppointment({super.key});

  @override
  State<CancelAppointment> createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  final List<String> reasons = [
    'appointments.anotherDoctor'.tr(),
    'appointments.recoveredIllness'.tr(),
    'appointments.suitableMedicine'.tr(),
    'appointments.moneyIssue'.tr(),
    'appointments.personalReason'.tr(),
    'appointments.justCancel'.tr()
  ];
  int selectedReason = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPreferances.padding),
      child: Column(
        children: [
          Text(
            'appointments.cancelReason'.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          verticalSpace(20),
          ...List.generate(
            reasons.length,
            (index) => Row(
              children: [
                Radio(
                  value: index,
                  fillColor: WidgetStateProperty.all(AppColors.mainColor),
                  groupValue: selectedReason,
                  activeColor: AppColors.mainColor,
                  onChanged: (value) {
                    setState(() {
                      selectedReason = value!;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedReason = index;
                    });
                  },
                  child: Text(reasons[index].tr(),
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

WoltModalSheetPage page1(
    BuildContext modalSheetContext, ValueNotifier<int> pageIndexNotifier) {
  return WoltModalSheetPage(
    hasTopBarLayer: false,
    backgroundColor: Theme.of(modalSheetContext).colorScheme.primary,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'appointments.cancelAppointment'.tr(),
            style: Theme.of(modalSheetContext).textTheme.titleLarge!.copyWith(
                  color: Colors.red,
                ),
          ),
          verticalSpace(20),
          Text(
            textAlign: TextAlign.center,
            'appointments.cancelAppointmentMessage'.tr(),
            style: Theme.of(modalSheetContext).textTheme.bodyMedium,
          ),
          verticalSpace(100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  backgroundColor: AppColors.mainColor.withAlpha(20),
                  buttonColor: AppColors.mainColor,
                  buttonName: 'appointments.no'.tr(),
                  onPressed: () {
                    Navigator.of(modalSheetContext).pop();
                    pageIndexNotifier.value = 0;
                  },
                  width: MediaQuery.of(modalSheetContext).size.width > 500
                      ? 200
                      : 150,
                  paddingVirtical: 5,
                  paddingHorizental: 10),
              horizontalSpace(10),
              CustomButton(
                buttonName: 'appointments.yes'.tr(),
                onPressed: () {
                  pageIndexNotifier.value = pageIndexNotifier.value + 1;
                },
                width: MediaQuery.of(modalSheetContext).size.width > 500
                    ? 200
                    : 150,
                paddingVirtical: 5,
                paddingHorizental: 10,
              )
            ],
          ),
        ],
      ),
    ),
  );
}

WoltModalSheetPage page2(
    BuildContext modalSheetContext, ValueNotifier<int> pageIndexNotifier) {
  return WoltModalSheetPage(
      hasTopBarLayer: false,
      backgroundColor: Theme.of(modalSheetContext).colorScheme.primary,
      child: Column(
        children: [
          CancelAppointment(),
          verticalSpace(20),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    backgroundColor: AppColors.mainColor.withAlpha(20),
                    buttonColor: AppColors.mainColor,
                    buttonName: 'appointments.cancel'.tr(),
                    onPressed: () {
                      Navigator.of(modalSheetContext).pop();
                      pageIndexNotifier.value = 0;
                    },
                    width: MediaQuery.of(modalSheetContext).size.width > 500
                        ? 200
                        : 150,
                    paddingVirtical: 5,
                    paddingHorizental: 10),
                horizontalSpace(10),
                CustomButton(
                  buttonName: 'appointments.submit'.tr(),
                  onPressed: () {},
                  width: MediaQuery.of(modalSheetContext).size.width > 500
                      ? 200
                      : 150,
                  paddingVirtical: 5,
                  paddingHorizental: 10,
                )
              ],
            ),
          )
        ],
      ));
}
