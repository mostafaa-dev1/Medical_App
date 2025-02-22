import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Doctor Profile',
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
              buttonName: 'Book Appointment',
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
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor:
                              AppColors.secondaryColor.withAlpha(30),
                          child: Icon(
                            IconBroken.User1,
                            size: 30,
                            color: AppColors.mainColor,
                          ),
                        ),
                        verticalSpace(10),
                        Text(
                          '5,000+',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.mainColor),
                        ),
                        verticalSpace(5),
                        Text(
                          'patients',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.lightBlue),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor:
                              AppColors.secondaryColor.withAlpha(30),
                          child: Icon(
                            Icons.medical_information_outlined,
                            size: 30,
                            color: AppColors.mainColor,
                          ),
                        ),
                        verticalSpace(10),
                        Text(
                          '10+',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.mainColor),
                        ),
                        verticalSpace(5),
                        Text(
                          'Experience',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.lightBlue),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor:
                              AppColors.secondaryColor.withAlpha(30),
                          child: Icon(
                            IconBroken.Star,
                            size: 30,
                            color: AppColors.mainColor,
                          ),
                        ),
                        verticalSpace(10),
                        Text(
                          '4.5',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.mainColor),
                        ),
                        verticalSpace(5),
                        Text(
                          'Rating',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.lightBlue),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor:
                              AppColors.secondaryColor.withAlpha(30),
                          child: Icon(
                            IconBroken.Chat,
                            size: 30,
                            color: AppColors.mainColor,
                          ),
                        ),
                        verticalSpace(10),
                        Text(
                          '5,000',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.mainColor),
                        ),
                        verticalSpace(5),
                        Text(
                          'Reviews',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.lightBlue),
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
                Text(
                  'About',
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
                  'Working Time',
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
                Text(
                  'Reviews',
                  style: Theme.of(context).textTheme.titleLarge,
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
                            child: Text(
                              '5 stars',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.secondaryColor),
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
