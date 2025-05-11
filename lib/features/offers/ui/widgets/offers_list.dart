import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/widgets/dialog.dart';
import 'package:medical_system/core/widgets/not_found.dart';
import 'package:medical_system/features/offers/logic/offers_cubit.dart';
import 'package:medical_system/features/offers/ui/widgets/offer_item.dart';
import 'package:medical_system/features/offers/ui/widgets/offers_loading.dart';

class OffersList extends StatelessWidget {
  const OffersList({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OffersCubit, OffersState>(
      listener: (context, state) {
        if (state is GetOffersError) {
          showCustomDialog(
              context: context,
              message: 'dialog.somethingWentWrong'.tr(),
              title: 'dialog.oops'.tr(),
              onConfirmPressed: () {
                context.pop();
              },
              confirmButtonName: 'dialog.ok'.tr(),
              dialogType: DialogType.error);
        }
      },
      builder: (context, state) {
        var cubit = context.read<OffersCubit>();
        final offers = cubit.offers;
        if (state is GetOffersLoading) {
          return OffersLoading();
        } else {
          if (offers == null || offers.isEmpty) {
            return const Center(child: NotFound());
          } else {
            return ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) {
                return OfferItem(
                  isVertical: true,
                  offers: offers[index],
                  user: user,
                );
              },
            );
          }
        }
      },
    );
  }
}
