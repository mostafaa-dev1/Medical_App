import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/custom_dropdown.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Edit Profile', style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPreferances.padding),
        child: Column(
          children: [
            CustomTextFrom(
              withhint: true,
              hintText: 'Name',
              controller: TextEditingController(),
              keyboardType: TextInputType.name,
            ),
            verticalSpace(10),
            CustomTextFrom(
              withhint: true,
              hintText: 'Birthday',
              controller: TextEditingController(),
              keyboardType: TextInputType.datetime,
            ),
            verticalSpace(10),
            CustomTextFrom(
              hintText: 'Phone',
              prefixText: '+20 ',
              controller: TextEditingController(),
              keyboardType: TextInputType.datetime,
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return 'Auth.dateOfBirthRequired'
              //         .tr();
              //   }
              //   return null;
              // }
            ),
            verticalSpace(10),
            AppCustomDropDown(
              list: ['Male', 'Female'],
              width: double.infinity,
              height: 50,
              text: 'Gender',
              hintText: 'Gender',
            ),
            Spacer(),
            CustomButton(
              onPressed: () {},
              paddingVirtical: 10,
              paddingHorizental: 10,
              buttonName: 'Save',
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
