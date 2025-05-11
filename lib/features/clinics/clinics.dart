import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/governments.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/clinics/logic/clinic_cubit.dart';
import 'package:medical_system/features/clinics/widgets/clinic_filter_values.dart';
import 'package:medical_system/features/clinics/widgets/clinics_list.dart';

class AppClinics extends StatefulWidget {
  const AppClinics(
      {super.key,
      required this.user,
      required this.government,
      required this.city});
  final UserModel user;
  final String government;
  final String city;

  @override
  State<AppClinics> createState() => _AppClinicsState();
}

class _AppClinicsState extends State<AppClinics> {
  int _selectedCity = 0;
  int _selectedRating = 0;
  int _selectedGovernment = 0;
  final List<String> _rating = [
    'All',
    '5',
    '4',
    '3',
    '2',
    '1',
  ];
  void checkGovernmentIndex(String gov) {
    for (int i = 0; i < Governments.allGovernments.length; i++) {
      if (Governments.allGovernments[i] == gov) {
        setState(() {
          _selectedGovernment = i;
        });
      }
    }
  }

  void checkCityIndex(String city) {
    for (int i = 0; i < Governments.citiesList.length; i++) {
      if (Governments.citiesList[i] == city) {
        setState(() {
          _selectedCity = i;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkGovernmentIndex(widget.government);
    checkCityIndex(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'home.clinics'.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            body: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: CustomTextFrom(
                //     onFieldSubmitted: (v) {
                //       context.read<ClinicCubit>().getClinics(
                //           name: v,
                //           ar: LanguageChecker.isArabic(context) ? true : false);
                //     },
                //     suffixIcon: IconButton(
                //         icon: Icon(
                //           IconBroken.Filter,
                //           color: AppColors.mainColor,
                //           size: 20,
                //         ),
                //         onPressed: () {
                //           showBottomSheet(context);
                //         }),
                //     // focusNode: _focusNode,
                //     hintText: 'search.search'.tr(),
                //     controller: TextEditingController(),
                //     keyboardType: TextInputType.text,
                //   ),
                // ),
                verticalSpace(10),
                GestureDetector(
                    onTap: () {
                      showBottomSheet(context);
                    },
                    child: ClinicFilterValues()),
                verticalSpace(10),
                ClinicsList(
                  user: widget.user,
                ),
              ],
            ));
      },
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      elevation: 2,
      builder: (context2) {
        return StatefulBuilder(
          builder: (context3, setModalState) => Container(
            height: 400,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Text(
                  'search.filter'.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                verticalSpace(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ratingFilter(setModalState),
                    verticalSpace(10),
                    cityFilter(setModalState),
                    verticalSpace(10),
                    governmentFilter(setModalState),
                    verticalSpace(50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          buttonName: 'search.reset'.tr(),
                          onPressed: () {
                            setState(() {
                              _selectedRating = 0;
                              _selectedCity = 0;
                              _selectedGovernment = 0;
                            });
                          },
                          width: MediaQuery.of(context).size.width > 500
                              ? 200
                              : 150,
                          paddingVirtical: 10,
                          paddingHorizental: 10,
                          backgroundColor:
                              AppColors.secondaryColor.withAlpha(10),
                          buttonColor: AppColors.mainColor,
                        ),
                        horizontalSpace(10),
                        CustomButton(
                            buttonName: 'search.apply'.tr(),
                            onPressed: () {
                              context.read<ClinicCubit>().applyFilters({
                                'rate': _rating[_selectedRating],
                                'city': Governments.citiesList[_selectedCity],
                                'government': Governments
                                    .allGovernments[_selectedGovernment]
                              });
                              context.pop();
                            },
                            width: MediaQuery.of(context).size.width > 500
                                ? 200
                                : 150,
                            paddingVirtical: 10,
                            paddingHorizental: 10),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget filterHeaderText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget ratingFilter(void Function(void Function()) setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filterHeaderText(
          'search.rating'.tr(),
        ),
        verticalSpace(5),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _rating.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setModalState(() {
                    _selectedRating = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: LanguageChecker.isArabic(context)
                          ? 0
                          : index == 0
                              ? 15
                              : 5,
                      right: LanguageChecker.isArabic(context)
                          ? index == 0
                              ? 15
                              : 5
                          : 0),
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _selectedRating == index
                        ? AppColors.mainColor
                        : AppColors.mainColor.withAlpha(20),
                  ),
                  child: Row(
                    children: [
                      _rating[index] == 'All'
                          ? SizedBox()
                          : Icon(
                              Icons.star,
                              color: _selectedRating == index
                                  ? Colors.white
                                  : AppColors.mainColor,
                              size: 18,
                            ),
                      _rating[index] == 'All' ? SizedBox() : horizontalSpace(5),
                      Text(
                          _rating[index] == 'All'
                              ? 'search.all'.tr()
                              : Format.formatNumber(
                                  int.parse(_rating[index]), context),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: _selectedRating == index
                                        ? Colors.white
                                        : AppColors.mainColor,
                                  )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget cityFilter(void Function(void Function()) setModalState) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      filterHeaderText(
        'search.city'.tr(),
      ),
      verticalSpace(5),
      SizedBox(
          height: 30,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Governments.cities.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setModalState(() {
                    _selectedCity = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: LanguageChecker.isArabic(context)
                          ? 0
                          : index == 0
                              ? 15
                              : 5,
                      right: LanguageChecker.isArabic(context)
                          ? index == 0
                              ? 15
                              : 5
                          : 0),
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _selectedCity == index
                        ? AppColors.mainColor
                        : AppColors.mainColor.withAlpha(20),
                  ),
                  child: Text(
                      Governments.cities[index] == 'city.All'
                          ? 'search.all'.tr()
                          : Governments.cities[index].tr(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: _selectedCity == index
                                ? Colors.white
                                : AppColors.mainColor,
                          )),
                ),
              );
            },
          ))
    ]);
  }

  Widget governmentFilter(void Function(void Function()) setModalState) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      filterHeaderText(
        'search.government'.tr(),
      ),
      verticalSpace(5),
      SizedBox(
          height: 30,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Governments.governments.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setModalState(() {
                    _selectedGovernment = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: LanguageChecker.isArabic(context)
                          ? 0
                          : index == 0
                              ? 15
                              : 5,
                      right: LanguageChecker.isArabic(context)
                          ? index == 0
                              ? 15
                              : 5
                          : 0),
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _selectedGovernment == index
                        ? AppColors.mainColor
                        : AppColors.mainColor.withAlpha(20),
                  ),
                  child: Text(
                      Governments.governments[index] == 'government.All'
                          ? 'search.all'.tr()
                          : Governments.governments[index].tr(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: _selectedGovernment == index
                                ? Colors.white
                                : AppColors.mainColor,
                          )),
                ),
              );
            },
          ))
    ]);
  }
}
