import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/custom_dropdown.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/core/widgets/overlay_loading.dart';
import 'package:medical_system/features/home/logic/main_cubit.dart';
import 'package:medical_system/features/personal_info/logic/personal_info_cubit.dart';
import 'package:medical_system/features/personal_info/widgets/date_of_birth.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    print(user.toJson());
    return BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
      listener: (context, state) {
        if (state is UploadImageError) {
          context.loaderOverlay.hide();
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              message: state.message.tr(),
              dialogType: DialogType.error,
              onConfirmPressed: () => context.pop(),
              confirmButtonName: 'dialog.ok'.tr(),
              title: 'dialog.oops'.tr(),
            ),
          );
        } else if (state is UploadPersonalInfoError) {
          context.loaderOverlay.hide();
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              message: state.message.tr(),
              dialogType: DialogType.error,
              onConfirmPressed: () => context.pop(),
              confirmButtonName: 'dialog.ok'.tr(),
              title: 'dialog.oops'.tr(),
            ),
          );
        } else if (state is UploadPersonalInfoLoading ||
            state is UploadImageLoading) {
          context.loaderOverlay.show();
        } else if (state is UploadPersonalInfoSuccess) {
          context.loaderOverlay.hide();
          context.pushNamedAndRemoveUntil(AppRoutes.mainScreen,
              arguments: FitchType.all);
        } else {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        var cubit = context.read<PersonalInfoCubit>();
        // cubit.nameController.text.isEmpty
        //     ? user.name
        //     : cubit.nameController.text;
        // cubit.imageUrl = user.image;
        return Scaffold(
          body: LoaderOverlay(
            overlayWidgetBuilder: (context2) => OverlayLoading(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: context.locale == Locale('ar')
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            'Auth.fillProfile'.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        verticalSpace(100),
                        Stack(
                          alignment: Alignment.topCenter,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context).colorScheme.primary,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Theme.of(context).colorScheme.shadow,
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 0),
                                    ),
                                  ]),
                              child: Form(
                                key: cubit.formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    verticalSpace(100),
                                    CustomTextFrom(
                                        hintText: 'Auth.firstName'.tr(),
                                        controller: cubit.firstNameController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Auth.nameRequired'.tr();
                                          }
                                          return null;
                                        }),
                                    verticalSpace(20),
                                    CustomTextFrom(
                                        hintText: 'Auth.lastName'.tr(),
                                        controller: cubit.lastNameController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Auth.nameRequired'.tr();
                                          }
                                          return null;
                                        }),
                                    verticalSpace(20),
                                    CustomTextFrom(
                                        hintText: 'Auth.phone'.tr(),
                                        prefixText: '+20 ',
                                        controller: cubit.phoneController,
                                        keyboardType: TextInputType.datetime,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 10) {
                                            return 'Auth.dateOfBirthRequired'
                                                .tr();
                                          }
                                          return null;
                                        }),
                                    verticalSpace(20),
                                    CustomTextFrom(
                                        readOnly: true,
                                        hintText: 'Auth.bof'.tr(),
                                        onTap: () {
                                          pickBirthDate(
                                            context,
                                            (index) {
                                              context
                                                  .read<PersonalInfoCubit>()
                                                  .formatDate(index);
                                            },
                                          );
                                        },
                                        controller: cubit.dateController,
                                        keyboardType: TextInputType.datetime,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Auth.dateOfBirthRequired'
                                                .tr();
                                          }
                                          return null;
                                        }),
                                    verticalSpace(20),
                                    AppCustomDropDown(
                                      list: [
                                        'Auth.male'.tr(),
                                        'Auth.female'.tr()
                                      ],
                                      width: double.infinity,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Auth.genderRequired'.tr();
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        cubit.gender = value!;
                                        return null;
                                      },
                                      height: 50,
                                      text: 'Auth.gender'.tr(),
                                      hintText: 'Auth.gender'.tr(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: -50,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: cubit.profileImage != null
                                        ? FileImage(cubit.profileImage!)
                                            as ImageProvider
                                        : cubit.imageUrl.isNotEmpty
                                            ? NetworkImage(cubit.imageUrl)
                                            : const AssetImage(
                                                'assets/images/user.png'), // Leave null for SVG

                                    // No child if image exists
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () => cubit.pickImage(),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: AppColors.mainColor,
                                          child: Icon(
                                            IconBroken.Camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(80),
                        CustomButton(
                          isLoading: state is UploadPersonalInfoLoading ||
                              state is UploadImageLoading,
                          buttonName: 'Auth.finish'.tr(),
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.managePersonalInfo(user);
                            }
                          },
                          width: MediaQuery.of(context).size.width / 1.5,
                          paddingVirtical: 10,
                          paddingHorizental: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
