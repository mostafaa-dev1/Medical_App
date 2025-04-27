import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class AppCustomDropDown extends StatelessWidget {
  const AppCustomDropDown(
      {super.key,
      required this.list,
      this.onChanged,
      required this.width,
      required this.height,
      required this.text,
      this.validator,
      required this.hintText,
      this.withHint,
      this.withSubhint,
      this.subHintText,
      this.initialItem});
  final List<String> list;
  final String? Function(String?)? onChanged;
  final double width;
  final double height;
  final String? Function(String?)? validator;
  final String text;
  final String hintText;
  final bool? withHint;
  final bool? withSubhint;
  final String? subHintText;
  final String? initialItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withHint ?? false
            ? Text(text, style: Theme.of(context).textTheme.labelLarge)
            : SizedBox(),
        withSubhint ?? false
            ? Text(subHintText!,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppColors.lightBlue,
                    ))
            : SizedBox(),
        withSubhint != null || withHint != null ? verticalSpace(5) : SizedBox(),
        SizedBox(
          width: double.infinity,
          height: height,
          child: CustomDropdown(
              overlayHeight: height,
              initialItem: initialItem,
              validator: (value) {
                return validator!(value);
              },
              hintText: hintText,
              enabled: true,
              closedHeaderPadding: const EdgeInsets.all(15),
              decoration: CustomDropdownDecoration(
                  listItemDecoration: ListItemDecoration(
                    highlightColor: Theme.of(context).colorScheme.primary,
                  ),
                  expandedSuffixIcon: const Icon(Icons.arrow_drop_up),
                  headerStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        locale: LanguageChecker.isArabic(context)
                            ? Locale('ar')
                            : Locale('en'),
                      ),
                  listItemStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            locale: LanguageChecker.isArabic(context)
                                ? Locale('ar')
                                : Locale('en'),
                          ),
                  expandedFillColor: Theme.of(context).colorScheme.primary,
                  expandedBorder: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  closedErrorBorder: Border.all(color: AppColors.lightRed),
                  closedErrorBorderRadius: BorderRadius.circular(10),
                  errorStyle: TextStyle(height: 1, color: AppColors.lightRed),
                  closedBorderRadius: BorderRadius.circular(10),
                  closedSuffixIcon: const Icon(Icons.arrow_drop_down),
                  closedFillColor: AppColors.mainColor.withAlpha(10),
                  closedBorder: Border.all(
                    color: AppColors.mainColor.withAlpha(20),
                  ),
                  hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.lightBlue,
                        locale: LanguageChecker.isArabic(context)
                            ? Locale('ar')
                            : Locale('en'),
                      )),
              items: list,
              onChanged: (v) {
                return onChanged!(v);
              }),
        ),
      ],
    );
  }
}
