import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/themes/colors.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 57,
          backgroundColor: AppColors.mainColor,
          child: CircleAvatar(
            radius: 55,
            backgroundImage: image.isNotEmpty
                ? NetworkImage(image)
                : const AssetImage('assets/images/user.png'),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: AppColors.mainColor,
                width: 2,
              ),
            ),
            child: const Icon(
              IconBroken.Edit,
              color: AppColors.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}
