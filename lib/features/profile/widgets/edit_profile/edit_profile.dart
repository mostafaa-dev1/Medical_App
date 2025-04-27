import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/custom_dropdown.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/personal_info/widgets/date_of_birth.dart';
import 'package:medical_system/features/profile/logic/profile_cubit.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdatePersonalInfoError) {
          showCustomDialog(
              context: context,
              message: 'editProfile.editProfileError'.tr(),
              title: 'dialog.oops'.tr(),
              onConfirmPressed: () {
                context.pop();
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error);
        }
        if (state is UpdatePersonalInfoSuccess) {
          showCustomDialog(
              context: context,
              message: 'editProfile.editProfileSuccess'.tr(),
              title: 'editProfile.success'.tr(),
              onConfirmPressed: () {
                context.pushNamedAndRemoveUntil(
                  AppRoutes.mainScreen,
                );
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.success);
        }
      },
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
          persistentFooterButtons: [
            CustomButton(
              isLoading: state is UpdatePersonalInfoLoading,
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.updatePersonalInfo(user);
                }
              },
              paddingVirtical: 10,
              paddingHorizental: 10,
              buttonName: 'editProfile.save'.tr(),
              width: double.infinity,
            )
          ],
          appBar: AppBar(
            title: Text('editProfile.editProfile'.tr(),
                style: Theme.of(context).textTheme.titleSmall),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPreferances.padding),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 57,
                          backgroundColor: AppColors.mainColor,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: cubit.image != null
                                ? FileImage(cubit.image!)
                                : user.image!.isNotEmpty
                                    ? CachedNetworkImageProvider(user.image!)
                                    : const AssetImage(
                                        'assets/images/user.png'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => cubit.pickImage(),
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
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    CustomTextFrom(
                      withhint: true,
                      hintText: 'editProfile.firstName'.tr(),
                      controller: cubit.firstNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Auth.firstNameRequired'.tr();
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    CustomTextFrom(
                      withhint: true,
                      hintText: 'editProfile.lastName'.tr(),
                      controller: cubit.lastNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Auth.lastNameRequired'.tr();
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    CustomTextFrom(
                      withhint: true,
                      hintText: 'editProfile.phone'.tr(),
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Auth.phoneRequired'.tr();
                        } else if (value.length < 11) {
                          return 'Auth.invalidPhone'.tr();
                        }
                        return null;
                      },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Auth.dateOfBirthRequired'
                      //         .tr();
                      //   }
                      //   return null;
                      // }
                    ),
                    verticalSpace(10),
                    CustomTextFrom(
                      enabled: false,
                      withhint: true,
                      hintText: 'editProfile.email'.tr(),
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Auth.emailRequired'.tr();
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    CustomTextFrom(
                      withhint: true,
                      readOnly: true,
                      hintText: 'editProfile.dateOfBirth'.tr(),
                      controller: cubit.birthdayController,
                      onTap: () {
                        pickBirthDate(
                          context,
                          (index) {
                            context.read<ProfileCubit>().formatDate(index);
                          },
                        );
                      },
                      keyboardType: TextInputType.datetime,
                    ),
                    verticalSpace(10),
                    AppCustomDropDown(
                      withHint: true,
                      list: [
                        'editProfile.male'.tr(),
                        'editProfile.female'.tr()
                      ],
                      width: double.infinity,
                      height: 50,
                      initialItem:
                          'editProfile.${cubit.gender!.toLowerCase()}'.tr(),
                      text: 'editProfile.gender'.tr(),
                      hintText: 'editProfile.gender'.tr(),
                      onChanged: (value) {
                        cubit.gender = value;
                        return null;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Auth.genderRequired'.tr();
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
