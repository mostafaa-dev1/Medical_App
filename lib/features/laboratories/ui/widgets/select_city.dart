import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/governments.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class SelectCity extends StatefulWidget {
  const SelectCity(
      {super.key,
      required this.type,
      required this.speciality,
      required this.user,
      required this.government});
  final String type;
  final String speciality;
  final UserModel user;
  final String government;

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        CustomButton(
          buttonName: 'laboratories.next'.tr(),
          onPressed: () {
            if (widget.type == 'Doctor') {
              context.pushNamed(AppRoutes.search, arguments: {
                'speciality': widget.speciality,
                'user': widget.user,
                'withSearch': false,
                'govrnment': widget.government,
                'city': Governments.citiesList[selected + 1],
              });
            } else if (widget.type == 'Lab') {
              context.pushNamed(AppRoutes.laboratories, arguments: {
                'specialty': widget.speciality,
                'govrnment': widget.government,
                'city': Governments.citiesList[selected + 1],
                'user': widget.user
              });
            } else {
              context.pushNamed(AppRoutes.clinics, arguments: {
                'government': widget.government,
                'city': Governments.citiesList[selected + 1],
                'user': widget.user
              });
            }
          },
          width: double.infinity,
          height: 40,
          paddingVirtical: 10,
          paddingHorizental: 10,
        )
      ],
      appBar: AppBar(
        title: Text(
          'laboratories.selectCity'.tr(),
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
            itemCount: Governments.cities.length - 1,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      Governments.cities[index + 1].tr(),
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
