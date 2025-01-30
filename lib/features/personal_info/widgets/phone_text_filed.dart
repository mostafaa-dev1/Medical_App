import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/register/widgets/personal_info/logic/personal_info_cubit.dart';

class PhoneTextFiled extends StatelessWidget {
  const PhoneTextFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      dropdownTextStyle: Theme.of(context).textTheme.labelLarge,
      keyboardType: TextInputType.phone,
      controller: context.read<PersonalInfoCubit>().phoneController,
      style: Theme.of(context).textTheme.bodyMedium!,
      validator: (value) {
        if (value == null || value.number.isEmpty) {
          return 'Auth.phoneRequired'.tr();
        }
        return null;
      },
      initialCountryCode: 'EG',
      textAlign:
          context.locale == Locale('ar') ? TextAlign.right : TextAlign.left,
      textInputAction: TextInputAction.next,
      invalidNumberMessage: 'Auth.invalidPhone'.tr(),
      pickerDialogStyle: PickerDialogStyle(
        padding: EdgeInsets.all(20),
        backgroundColor: Colors.white,
        countryCodeStyle: Theme.of(context).textTheme.labelMedium,
        listTileDivider: Divider(color: Colors.grey[300]),
        listTilePadding: EdgeInsets.zero,
        searchFieldInputDecoration: InputDecoration(
          hintText: 'Auth.search'.tr(),
          hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.lightBlue,
              ),
        ),
        countryNameStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      dropdownIcon: Icon(
        Icons.arrow_drop_down,
        color: AppColors.mainColor,
      ),
      decoration: InputDecoration(
        counterText: '',
        hintText: 'Auth.phone'.tr(),
        hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColors.lightBlue,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.mainColor,
          ),
        ),
        contentPadding: EdgeInsets.all(10),
      ),
    );
  }
}
