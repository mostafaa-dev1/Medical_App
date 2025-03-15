import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medical_system/core/themes/colors.dart';

class OverlayLoading extends StatelessWidget {
  const OverlayLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: LoadingAnimationWidget.threeArchedCircle(
            color: AppColors.mainColor, size: 50),
      ),
    );
  }
}
