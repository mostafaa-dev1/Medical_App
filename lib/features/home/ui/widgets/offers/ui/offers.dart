import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/features/home/logic/main_cubit.dart';
import 'package:medical_system/features/home/ui/widgets/home_header_item.dart';
import 'package:medical_system/features/home/ui/widgets/offers/ui/widgets/offer_item.dart';
import 'package:medical_system/features/home/ui/widgets/offers/ui/widgets/offers_loading.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      var mainCubit = context.read<MainCubit>();
      final offers = mainCubit.offers;
      if (state is GetOffersLoading || mainCubit.isOffersLoading) {
        return OffersLoading();
      } else {
        if (offers.offers.isEmpty) {
          return const SizedBox();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderItem(onPress: () {}, title: 'home.offers'.tr()),
              SizedBox(
                height: 305,
                child: ListView.builder(
                    itemCount: offers.offers.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return OfferItem(
                        offers: offers.offers[index],
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
