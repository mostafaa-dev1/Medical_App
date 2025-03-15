// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/country_picker_dialog.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:medical_system/core/helpers/spacing.dart';
// import 'package:medical_system/core/themes/colors.dart';

// class PhoneTextFiled extends StatelessWidget {
//   const PhoneTextFiled({super.key, required this.controller, this.hint});
//   final TextEditingController controller;
//   final String? hint;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (hint != null)
//           Text(hint!, style: Theme.of(context).textTheme.labelLarge),
//         if (hint != null) verticalSpace(10),
//         IntlPhoneField(
//           dropdownTextStyle: Theme.of(context).textTheme.labelLarge,
//           keyboardType: TextInputType.phone,
//           controller: controller,
//           style: Theme.of(context).textTheme.bodyMedium!,
//           validator: (value) {
//             if (value == null || value.number.isEmpty) {
//               return 'Auth.phoneRequired'.tr();
//             }
//             return null;
//           },
//           initialCountryCode: 'EG',
//           textAlign:
//               context.locale == Locale('ar') ? TextAlign.right : TextAlign.left,
//           textInputAction: TextInputAction.next,
//           invalidNumberMessage: 'Auth.invalidPhone'.tr(),
//           pickerDialogStyle: PickerDialogStyle(
//             padding: EdgeInsets.all(20),
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             countryCodeStyle: Theme.of(context).textTheme.labelMedium,
//             listTileDivider: Divider(color: Colors.grey[300]),
//             listTilePadding: EdgeInsets.zero,
//             searchFieldInputDecoration: InputDecoration(
//               hintText: 'Auth.search'.tr(),
//               hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
//                     color: AppColors.lightBlue,
//                   ),
//             ),
//             countryNameStyle: Theme.of(context).textTheme.bodyMedium,
//           ),
//           dropdownIcon: Icon(
//             Icons.arrow_drop_down,
//             color: AppColors.mainColor,
//           ),
//           decoration: InputDecoration(
//             counterText: '',
//             hintText: 'Auth.phone'.tr(),
//             hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
//                   color: AppColors.lightBlue,
//                 ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             fillColor: AppColors.mainColor.withAlpha(20),
//             filled: true,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Colors.grey[300]!,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: AppColors.mainColor,
//               ),
//             ),
//             contentPadding: EdgeInsets.all(10),
//           ),
//         ),
//       ],
//     );
//   }
// }
