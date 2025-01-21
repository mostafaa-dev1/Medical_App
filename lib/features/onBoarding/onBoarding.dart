import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_system/core/logic/app_cubit.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'onBoard'.tr(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Text(
                  context.locale.languageCode,
                ),
                Text(
                  'onBoard'.tr(),
                  style: GoogleFonts.cairo(),
                ),
                Text(
                  context.read<AppCubit>().themeMode.toString(),
                ),
                Text(
                  context.read<AppCubit>().fontStyle.toString(),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AppCubit>().changeThemeMode();
                  },
                  child: const Text('English'),
                ),
                TextButton(
                    child: const Text('Change Language'),
                    onPressed: () {
                      context.read<AppCubit>().toggleLanguage(context);
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
