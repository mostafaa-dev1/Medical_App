import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/features/offers/ui/widgets/offers_list.dart';

class Offers extends StatelessWidget {
  const Offers({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'home.offers'.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: OffersList(
        user: user,
      ),
    );
  }
}
