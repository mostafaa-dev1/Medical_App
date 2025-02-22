import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/personal_info/logic/personal_info_cubit.dart';
import 'package:medical_system/features/personal_info/widgets/date_of_birth.dart';
import 'package:medical_system/features/personal_info/widgets/male_female.dart';
import 'package:medical_system/features/personal_info/widgets/phone_text_filed.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
      listener: (context, state) {
        if (state is UploadImageError) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              message: state.message.tr(),
              isError: true,
            ),
          );
        } else if (state is UploadPersonalInfoError) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              message: state.message.tr(),
              isError: true,
            ),
          );
        } else if (state is UploadPersonalInfoSuccess) {
          context.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
        }
      },
      builder: (context, state) {
        var cubit = context.read<PersonalInfoCubit>();
        cubit.nameController.text.isEmpty
            ? user.name
            : cubit.nameController.text;
        cubit.imageUrl = user.image;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      verticalSpace(30),
                      Stack(
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
                      verticalSpace(50),
                      CustomTextFrom(
                          hintText: 'Auth.name'.tr(),
                          controller: cubit.nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Auth.nameRequired'.tr();
                            }
                            return null;
                          }),
                      verticalSpace(20),
                      PhoneTextFiled(),
                      verticalSpace(20),
                      CustomTextFrom(
                          readOnly: true,
                          hintText: 'Auth.bof'.tr(),
                          onTap: () {
                            pickBirthDate(context);
                          },
                          controller: cubit.dateController,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Auth.dateOfBirthRequired'.tr();
                            }
                            return null;
                          }),
                      verticalSpace(20),
                      MaleFemale(),
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
        );
      },
    );
  }
}
