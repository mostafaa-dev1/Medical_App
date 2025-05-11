import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/features/main/logic/main_cubit.dart';
import 'package:medical_system/features/home/ui/widgets/home_header_item.dart';
import 'package:medical_system/features/offers/ui/widgets/offer_item.dart';
import 'package:medical_system/features/offers/ui/widgets/offers_home_loading.dart';

class Offers extends StatelessWidget {
  const Offers({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      var mainCubit = context.read<MainCubit>();
      final offers = mainCubit.offers;
      if (state is GetOffersLoading || mainCubit.isOffersLoading) {
        return OffersHomeLoading();
      } else {
        if (offers.offers.isEmpty) {
          return const SizedBox();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderItem(
                  onPress: () {
                    context.pushNamed(
                      AppRoutes.offers,
                      arguments: {
                        'user': context.read<MainCubit>().user,
                        'provider': type
                      },
                    );
                  },
                  title: 'home.offers'.tr()),
              SizedBox(
                height: 305,
                child: ListView.builder(
                    itemCount: offers.offers.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return OfferItem(
                        isVertical: false,
                        offers: offers.offers[index],
                        user: context.read<MainCubit>().user,
                      );
                    }),
              )
            ],
          );
        }
      }
    });
  }
}
