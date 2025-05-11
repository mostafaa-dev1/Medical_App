import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/core/constants/governments.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/specialities.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/laboratories/logic/laboratories_cubit.dart';
import 'package:medical_system/features/laboratories/ui/widgets/lab_filter_values.dart';
import 'package:medical_system/features/laboratories/ui/widgets/labs_list.dart';

class Laboratories extends StatefulWidget {
  const Laboratories(
      {super.key,
      required this.specialty,
      required this.city,
      required this.government,
      required this.user});
  final String specialty;
  final String city;
  final String government;
  final UserModel user;

  @override
  State<Laboratories> createState() => _LaboratoriesState();
}

class _LaboratoriesState extends State<Laboratories> {
  int _selectedSpeciality = 0;
  int _selectedRating = 0;
  int _selectedCity = 0;
  int _selectedGovernment = 0;
  final List<String> _rating = [
    'All',
    '5',
    '4',
    '3',
    '2',
    '1',
  ];
  void checkSpecialityIndex(String speciality) {
    for (int i = 0; i < Specialities.labSpecialities.length; i++) {
      if (Specialities.labSpecialities[i] == speciality) {
        setState(() {
          _selectedSpeciality = i;
        });
      }
    }
  }

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
    checkSpecialityIndex(widget.specialty);
    checkGovernmentIndex(widget.government);
    checkCityIndex(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaboratoriesCubit, LaboratoriesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.specialty == 'All'
                  ? 'laboratories.laboratories'.tr()
                  : 'laboratories.${widget.specialty}'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          body: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: CustomTextFrom(
              //     onFieldSubmitted: (v) {
              //       context.read<LaboratoriesCubit>().getLabs(
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
              //           showBottomSheet();
              //         }),
              //     // focusNode: _focusNode,
              //     hintText: 'search.searchbyName'.tr(),
              //     controller: context.read<LaboratoriesCubit>().searchController,
              //     keyboardType: TextInputType.text,
              //   ),
              // ),
              verticalSpace(10),
              GestureDetector(
                  onTap: () {
                    showBottomSheet();
                  },
                  child: LabFilterValues()),
              verticalSpace(10),
              LabsList(
                user: widget.user,
              ),
            ],
          ),
        );
      },
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      elevation: 2,
      builder: (context2) {
        return StatefulBuilder(
          builder: (context3, setModalState) => Container(
            height: 500,
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
                    spcialityFilter(setModalState),
                    verticalSpace(10),
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
                              _selectedSpeciality = 0;
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
                              context.read<LaboratoriesCubit>().applyFilters({
                                'speciality': Specialities
                                    .labSpecialities[_selectedSpeciality],
                                'rating': _rating[_selectedRating],
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

  Widget spcialityFilter(void Function(void Function()) setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        filterHeaderText(
          'search.speciality'.tr(),
        ),
        verticalSpace(5),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Specialities.labList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setModalState(() {
                    _selectedSpeciality = index;
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
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _selectedSpeciality == index
                        ? AppColors.mainColor
                        : AppColors.mainColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(Specialities.labList[index].tr(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: _selectedSpeciality == index
                                ? Colors.white
                                : AppColors.mainColor,
                          )),
                ),
              );
            },
          ),
        ),
      ],
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
