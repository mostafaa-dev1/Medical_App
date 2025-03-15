import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/features/ai_chat/widgets/ai_message.dart';
import 'package:medical_system/features/ai_chat/widgets/user_message.dart';

class AiChat extends StatelessWidget {
  const AiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delma Assistant',
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AiMessage(),
            verticalSpace(10),
            UserMessage(),
            Spacer(),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Row(children: [
                Expanded(
                  child: CustomTextFrom(
                      hintText: 'Enter your message',
                      controller: TextEditingController(),
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
                  onPressed: () {},
                  child: Icon(IconBroken.Send, color: Colors.white, size: 20),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
