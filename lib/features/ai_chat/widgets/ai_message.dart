import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/themes/colors.dart';

class AiMessage extends StatelessWidget {
  const AiMessage(
      {super.key,
      required this.message,
      required this.loading,
      required this.type,
      this.choices});
  final String message;
  final String type;
  final bool loading;
  final List<dynamic>? choices;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: LanguageChecker.isArabic(context)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: LanguageChecker.isArabic(context)
                ? Radius.zero
                : Radius.circular(20),
            bottomLeft: LanguageChecker.isArabic(context)
                ? Radius.circular(20)
                : Radius.zero,
          ),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: loading
            ? LoadingAnimationWidget.waveDots(
                color: AppColors.mainColor, size: 18)
            : Column(
                children: [
                  Text(
                      type == 'Spciality'
                          ? '${'home.youNeed'.tr()} ${'specialities.$message'.tr()}'
                          : message,
                      style: Theme.of(context).textTheme.bodySmall),
                  // if (choices != null)
                  //   Column(
                  //     children: choices!
                  //         .map(
                  //           (e) => GestureDetector(
                  //             onTap: () {
                  //               context
                  //                   .read<AiMedicalHistroyCubit>()
                  //                   .addMessage(messge: e);
                  //             },
                  //             child: Container(
                  //               constraints:
                  //                   const BoxConstraints(maxWidth: 100),
                  //               padding: const EdgeInsets.all(5),
                  //               margin: const EdgeInsets.only(top: 5),
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   color:
                  //                       Theme.of(context).colorScheme.primary,
                  //                   border: Border.all(
                  //                     color: AppColors.mainColor,
                  //                   )),
                  //               child: Center(
                  //                 child: Text(
                  //                   e,
                  //                   style:
                  //                       Theme.of(context).textTheme.bodySmall,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  // ),
                ],
              ),
      ),
    );
  }
}
