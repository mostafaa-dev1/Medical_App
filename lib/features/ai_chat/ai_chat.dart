import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/features/ai_chat/logic/ai_cubit.dart';
import 'package:medical_system/features/ai_chat/widgets/ai_message.dart';
import 'package:medical_system/features/ai_chat/widgets/ai_search_item.dart';
import 'package:medical_system/features/ai_chat/widgets/ai_search_loading.dart';
import 'package:medical_system/features/ai_chat/widgets/user_message.dart';

class AiChat extends StatelessWidget {
  AiChat({super.key, required this.user});
  final UserModel user;
  final ScrollController scrollController = ScrollController();
  void _scrollToBottom() {
    if (scrollController.hasClients) {
      // Ensure that the controller is attached to the widget and scroll to the bottom
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiCubit, AiState>(
      listener: (context, state) {
        if (state is AiMessageAdded ||
            state is AiSuccess ||
            state is FitchDoctorsSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        } else if (state is LocationError) {
          if (state.errMessage == 'dialog.locationDisabled') {
            showCustomDialog(
              context: context,
              message: state.errMessage.tr(),
              title: 'dialog.oops'.tr(),
              onConfirmPressed: () {
                context.read<AiCubit>().openLocationSettings();
                context.pop();
              },
              confirmButtonName: 'dialog.enableLocation'.tr(),
              dialogType: DialogType.warning,
              withTowButtons: true,
              cancelButtonName: 'dialog.cancel'.tr(),
            );
          } else {
            showCustomDialog(
              context: context,
              message: state.errMessage.tr(),
              title: 'dialog.oops'.tr(),
              onConfirmPressed: () {
                context.pop();
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error,
            );
          }
        }
        if (state is NoInternetConnection) {
          showCustomDialog(
            context: context,
            message: 'dialog.noInternetConnection'.tr(),
            title: 'dialog.oops'.tr(),
            onConfirmPressed: () {
              context.pop();
            },
            confirmButtonName: 'dialog.ok'.tr(),
            dialogType: DialogType.error,
          );
        }
      },
      builder: (context, state) {
        var cubit = context.read<AiCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('home.aiAssistant'.tr(),
                style: Theme.of(context).textTheme.titleSmall),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: cubit.data.length +
                        (state is AiLoading
                            ? 1
                            : 0), // Add extra item when loading
                    itemBuilder: (context, index) {
                      if (state is AiLoading && index == cubit.data.length) {
                        return AiMessage(type: '', message: '', loading: true);
                      }

                      final message = cubit.data[index];
                      if (message["role"] == "user") {
                        return UserMessage(
                            message: message["parts"][0]["text"]);
                      } else if (message["role"] == "model") {
                        return AiMessage(
                          type: message["type"],
                          message: message["parts"][0]["text"],
                          loading: false,
                        );
                      } else if (message["role"] == "list") {
                        return state is FitchDoctorsLoading ||
                                cubit.doctors.clinics == null
                            ? AiSearchLoading()
                            : AiSearchItem(
                                clinics: cubit.doctors,
                                user: user,
                              );
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Row(children: [
                    Expanded(
                      child: CustomTextFrom(
                          hintText: 'home.enterMessage'.tr(),
                          controller: cubit.messageController,
                          keyboardType: TextInputType.text),
                    ),
                    horizontalSpace(10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(50, 45),
                        backgroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        elevation: 0,
                      ),
                      onPressed: () {
                        context.read<AiCubit>().addMessage();
                      },
                      child:
                          Icon(IconBroken.Send, color: Colors.white, size: 20),
                    )
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
