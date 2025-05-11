import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/responsive/responsive.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key, required this.user, required this.type});
  final UserModel user;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      height: Responsive.appWidth(context) > 600 ? 180.h : 160.h,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Color(0xff18285B), Color(0xff4F6AC6)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // SvgPicture.asset(
                  //   'assets/images/logo_white.svg',
                  //   width: 18,
                  //   height: 18,
                  // ),
                  //horizontalSpace(5),
                  Text(
                    'Delma',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              verticalSpace(5),
              Text(
                'home.stayHealthy'.tr().toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      height: 1.2,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              verticalSpace(5),
              Text(
                'home.bookAndStayHealthy'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white, height: 1.2),
              ),
              Spacer(),
              CustomButton(
                backgroundColor: Colors.white,
                buttonColor: AppColors.mainColor,
                buttonName: 'home.bookNow'.tr(),
                fontSize: 12,
                height: 30,
                onPressed: () async {
                  if (type == 'Clinic') {
                    context.pushNamed(AppRoutes.selectGovernment, arguments: {
                      'type': type,
                      'specialty': '',
                      'user': user
                    });
                  } else {
                    context.pushNamed(AppRoutes.spcialities,
                        arguments: {'user': user, 'type': type});
                  }
                  //LocalNotifications.showNotification();
                  // context.pushNamed(AppRoutes.spcialities,
                  //     arguments: {'user': user, 'type': type});
                  //context.read<MainCubit>().getCityAndStreetName();
                  //Paymob().getToken();
                  //print(await context.read<MainCubit>().hasInternetAccess());
                },
                width: 100,
                paddingVirtical: 0,
                paddingHorizental: 5,
              ),
            ],
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: Image(
              alignment: Alignment.bottomRight,
              image: AssetImage(
                'assets/images/${type == 'Doctor' ? 'doc' : type == 'Clinic' ? 'clinics' : 'labs'}.png',
              ),
              fit: BoxFit.fill,
              width: type == 'Clinic' ? 140 : 120,
              height: 140,
            ),
          )
        ],
      ),
    );
  }
}
