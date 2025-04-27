import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class ServicesItem extends StatelessWidget {
  const ServicesItem(
      {super.key,
      required this.onTap,
      required this.title,
      required this.description,
      required this.buttonName,
      required this.image});
  final VoidCallback onTap;
  final String title;
  final String description;
  final String buttonName;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            image,
            height: 25,
            width: 30,
          ),
          horizontalSpace(5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                verticalSpace(5),
                Text(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    description,
                    style: Theme.of(context).textTheme.labelSmall!)
              ],
            ),
          ),
          horizontalSpace(10),
          CustomButton(
              buttonName: buttonName,
              onPressed: onTap,
              height: 30,
              fontSize: 12,
              width: 80,
              paddingVirtical: 0,
              paddingHorizental: 10)
        ],
      ),
    );
  }
}
