import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/themes/colors.dart';

void pickBirthDate(BuildContext context, Function(dynamic)? onSubmit) {
  BottomPicker.date(
    pickerTitle: Text(
      'Set your Birthday',
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    dateOrder: DatePickerDateOrder.mdy,
    initialDateTime: DateTime.now(),
    maxDateTime: DateTime.now(),
    closeIconColor: AppColors.darkBlue,
    backgroundColor: Colors.white,
    dismissable: true,
    titleAlignment: Alignment.center,
    minDateTime: DateTime(1950),
    pickerTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColors.secondaryColor,
        ),
    onSubmit: onSubmit,
    bottomPickerTheme: BottomPickerTheme.morningSalad,
    buttonStyle: BoxDecoration(
      color: AppColors.mainColor,
      borderRadius: BorderRadius.circular(10),
    ),
  ).show(context);
}
