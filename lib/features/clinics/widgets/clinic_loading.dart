import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ClinicsLoading extends StatelessWidget {
  const ClinicsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        enabled: true,
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow,
                        spreadRadius: 3,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          height: 100,
                          width:
                              100, // <-- Add width to image to fix layout nicely
                          image: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        // <-- Wrap Column with Expanded
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Name',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColors.mainColor,
                                      size: 15,
                                    ),
                                    horizontalSpace(5),
                                    Text(
                                      '4.5',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpace(5),
                            Text(
                              'Medical',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            verticalSpace(5),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4), // Add padding
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.mainColor.withAlpha(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Important to prevent taking full width
                                children: [
                                  Icon(Icons.home,
                                      size: 16), // reduce size a little
                                  horizontalSpace(5),
                                  Text(
                                    'Home Sample Available',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
      ),
    );
  }
}
