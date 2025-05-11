import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/governments.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class SelectGovernment extends StatefulWidget {
  const SelectGovernment(
      {super.key,
      required this.type,
      required this.speciality,
      required this.user});
  final String type;
  final String speciality;
  final UserModel user;

  @override
  State<SelectGovernment> createState() => _SelectGovernmentState();
}

class _SelectGovernmentState extends State<SelectGovernment> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        CustomButton(
          buttonName: 'laboratories.next'.tr(),
          onPressed: () {
            context.pushNamed(AppRoutes.selectCity, arguments: {
              'specialty': widget.speciality,
              'government': Governments.allGovernments[selected + 1],
              'type': widget.type,
              'user': widget.user
            });
          },
          width: double.infinity,
          height: 40,
          paddingVirtical: 10,
          paddingHorizental: 10,
        )
      ],
      appBar: AppBar(
        title: Text(
          'laboratories.selectGovernment'.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.appWidth(context) > 600 ? 5 : 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5,
            ),
            itemCount: Governments.governments.length - 1,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selected = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selected == index
                        ? AppColors.mainColor
                        : AppColors.mainColor.withAlpha(20),
                  ),
                  child: Center(
                    child: Text(
                      Governments.governments[index + 1].tr(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: selected == index ? Colors.white : null,
                          ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
