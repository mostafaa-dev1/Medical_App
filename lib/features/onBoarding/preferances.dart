import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/logic/app_cubit.dart';

class Preferances extends StatelessWidget {
  const Preferances({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    context.read<AppCubit>().changeThemeMode();
                  },
                  child: Text('English',
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                TextButton(
                    child: Text('Change Language',
                        style: Theme.of(context).textTheme.bodyMedium),
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
