import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/doctor_profile/widgets/experince_item.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('doctorProfile.doctorProfile'.tr(),
              style: Theme.of(context).textTheme.titleSmall),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.heart,
                  color: AppColors.mainColor,
                ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 50,
          padding: EdgeInsets.zero,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CustomButton(
              onPressed: () {
                context.pushNamed(AppRoutes.pickAppointmentDate);
              },
              buttonName: 'doctorProfile.bookAppointment'.tr(),
              width: 120,
              paddingVirtical: 5,
              height: 50,
              borderRadius: 20,
              paddingHorizental: 10,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPreferances.padding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.primary,
                          border: Border.all(
                            color: AppColors.mainColor,
                          )),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                            image: AssetImage('assets/images/doctor.png'),
                            fit: BoxFit.fill,
                          )),
                    ),
                    horizontalSpace(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. John Doe',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        verticalSpace(5),
                        Text(
                          'Brain and Nerves doctor',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        verticalSpace(5),
                        Text(
                          'Egypt/Cairo',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(20),
                Divider(
                  color: Theme.of(context).dividerColor,
                  indent: AppPreferances.screenWidth(context) / 5.5,
                  endIndent: AppPreferances.screenWidth(context) / 5.5,
                ),
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ExperinceItem(
                        title: 'doctorProfile.patients'.tr(),
                        amount: '5,000+',
                        icon: IconBroken.User1),
                    ExperinceItem(
                        title: 'doctorProfile.experince'.tr(),
                        amount: '10+',
                        icon: Icons.medical_information_outlined),
                    ExperinceItem(
                        title: 'doctorProfile.rating'.tr(),
                        amount: '4.5',
                        icon: IconBroken.Star),
                    ExperinceItem(
                        title: 'doctorProfile.reviews'.tr(),
                        amount: '5,000',
                        icon: IconBroken.Chat),
                  ],
                ),
                verticalSpace(20),
                Divider(
                  color: Theme.of(context).dividerColor,
                  indent: AppPreferances.screenWidth(context) / 5.5,
                  endIndent: AppPreferances.screenWidth(context) / 5.5,
                ),
                verticalSpace(20),
                Text(
                  'doctorProfile.about'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                verticalSpace(10),
                Text(
                  'Dr. John Doe is a doctor who specializes in brain and nervous system disorders. He has been in practice for over 20 years and has been recognized for his expertise in treating patients with neurological disorders. He is a highly respected and respected doctor in the community.',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.5,
                        color: AppColors.lightBlue,
                      ),
                ),
                verticalSpace(20),
                Text(
                  'doctorProfile.workingTime'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                verticalSpace(10),
                Text(
                  'Mon - Sun: 8:00 - 17:00',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.5,
                        color: AppColors.lightBlue,
                      ),
                ),
                verticalSpace(20),
                Row(
                  children: [
                    Text(
                      'doctorProfile.reviews'.tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.reviews);
                      },
                      child: Text(
                        'doctorProfile.seeAll'.tr(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              height: 1.5,
                              color: AppColors.secondaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: const NetworkImage(
                                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'),
                          ),
                          horizontalSpace(10),
                          Text(
                            'John Doe',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: AppColors.secondaryColor),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColors.secondaryColor,
                                  size: 15,
                                ),
                                horizontalSpace(5),
                                Text(
                                  '5',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: AppColors.secondaryColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      verticalSpace(10),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestias, accusantium, vero, officiis laboriosam quos ut quae cumque doloribus placeat quidem voluptates quibusdam natus. Quia, quidem. Quos, quae. Quisquam, quod.',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              height: 1.5,
                              color: AppColors.lightBlue,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
