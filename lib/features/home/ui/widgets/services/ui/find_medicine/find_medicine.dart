import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/home/ui/widgets/services/logic/services_cubit.dart';

class FindMedicine extends StatelessWidget {
  const FindMedicine({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
        if (state is ServicesError) {
          showDialog(
              context: context,
              builder: (context) => CustomDialog(
                    dialogType: DialogType.error,
                    title: 'dialog.oops'.tr(),
                    confirmButtonName: 'dialog.ok'.tr(),
                    onConfirmPressed: () => context.pop(),
                    message: 'findMedicine.findMedicineError'.tr(),
                  ));
        } else if (state is ServicesSuccess) {
          showDialog(
              context: context,
              builder: (context) => CustomDialog(
                    dialogType: DialogType.success,
                    title: 'dialog.sentSuccess'.tr(),
                    confirmButtonName: 'dialog.ok'.tr(),
                    onConfirmPressed: () => context.pop(),
                    message: 'findMedicine.findMedicineSuccess'.tr(),
                  ));
        } else if (state is NoInternetConnection) {
          showCustomDialog(
            context: context,
            message: 'dialog.noInternetConnection'.tr(),
            title: 'dialog.oops',
            onConfirmPressed: () {
              context.pop();
            },
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.warning,
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<ServicesCubit>();
        return Scaffold(
          persistentFooterButtons: [
            CustomButton(
              isLoading: state is ServicesLoading,
              onPressed: () {
                if (cubit.findMedicineKey.currentState!.validate()) {
                  cubit.findMedicine(userId);
                }
              },
              buttonName: 'Send'.tr(),
              width: double.infinity,
              paddingVirtical: 5,
              height: 40,
              paddingHorizental: 10,
            ),
          ],
          appBar: AppBar(
            title: Text(
              'findMedicine.findMedicine'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPreferances.padding),
              child: Form(
                key: cubit.findMedicineKey,
                child: Column(
                  children: [
                    Text(
                      'findMedicine.sendUs'.tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    verticalSpace(10),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (cubit.pickedImage == null) cubit.pickImage();
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                cubit.pickedImage != null ? 0 : 20),
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        AppColors.secondaryColor.withAlpha(30),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.secondaryColor.withAlpha(15)),
                            child: cubit.pickedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      cubit.pickedImage!,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        IconBroken.Upload,
                                        size: 50,
                                      ),
                                      verticalSpace(15),
                                      Text(
                                        textAlign: TextAlign.center,
                                        'findMedicine.upload'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        cubit.pickedImage != null
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                    onPressed: () {
                                      cubit.pickImage();
                                    },
                                    icon: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            cubit.deleteImage();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.delete,
                                                  size: 15,
                                                  color: AppColors.mainColor,
                                                ),
                                                horizontalSpace(5),
                                                Text('findMedicine.delete'.tr(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall),
                                              ],
                                            ),
                                          ),
                                        ),
                                        horizontalSpace(5),
                                        GestureDetector(
                                          onTap: () {
                                            cubit.pickImage();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.change_circle_outlined,
                                                  size: 15,
                                                  color: AppColors.mainColor,
                                                ),
                                                horizontalSpace(5),
                                                Text('findMedicine.change'.tr(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    verticalSpace(20),
                    CustomTextFrom(
                      hintText: 'findMedicine.medicineName'.tr(),
                      controller: cubit.medicineNameController,
                      keyboardType: TextInputType.text,
                      withhint: true,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'findMedicine.medicineNameRequired'.tr();
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    CustomTextFrom(
                      validator: (v) {
                        return null;
                      },
                      hintText: 'findMedicine.notes'.tr(),
                      controller: cubit.medicineNotesController,
                      keyboardType: TextInputType.text,
                      withhint: true,
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
