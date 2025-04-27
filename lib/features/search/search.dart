import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/constants/governments.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/constants/specialities.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/format.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/features/search/logic/search_cubit.dart';
import 'package:medical_system/features/search/widgets/filter_values.dart';
import 'package:medical_system/features/search/widgets/search_list.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.user});
  final UserModel user;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<String> _rating = [
    'All',
    '5',
    '4',
    '3',
    '2',
    '1',
  ];

  int _selectedRating = 0;
  int _selectedSpeciality = 0;
  int? selectedPrice;
  int _selectedGovernment = 0;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    getSpecialityIndex();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  void getSpecialityIndex() {
    for (int i = 0; i < Specialities.list.length; i++) {
      if (Specialities.list[i] ==
          context.read<SearchCubit>().filterValues['speciality']) {
        setState(() {
          _selectedSpeciality = i;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Expanded(
                        child: CustomTextFrom(
                          onFieldSubmitted: (v) {
                            context.read<SearchCubit>().search(
                                firstName: v,
                                ar: LanguageChecker.isArabic(context)
                                    ? true
                                    : false);
                          },
                          suffixIcon: IconButton(
                              icon: Icon(
                                IconBroken.Filter,
                                color: AppColors.mainColor,
                                size: 20,
                              ),
                              onPressed: () {
                                showBottomSheet();
                              }),
                          // focusNode: _focusNode,
                          hintText: 'search.search'.tr(),
                          controller: TextEditingController(),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      showBottomSheet();
                    },
                    child: FilterValues()),
                // verticalSpace(20),
                //Suggestions(),
                verticalSpace(20),
                SearchList(
                  user: widget.user,
                )
              ],
            ),
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
                    priceFilter(setModalState),
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
                              selectedPrice = null;
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
                              context.read<SearchCubit>().applyFilters({
                                'speciality': Specialities
                                    .specialities[_selectedSpeciality],
                                'rate': _rating[_selectedRating],
                                'price': selectedPrice == 0
                                    ? 'Highest Price'
                                    : selectedPrice == 1
                                        ? 'Lowest Price'
                                        : null,
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
            itemCount: Specialities.list.length,
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
                  child: Text(Specialities.list[index].tr(),
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

  Widget priceFilter(void Function(void Function()) setModalState) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      filterHeaderText(
        'search.price'.tr(),
      ),
      verticalSpace(5),
      Row(
        children: [
          GestureDetector(
            onTap: () {
              setModalState(() {
                selectedPrice = 0;
              });
            },
            child: Container(
              height: 30,
              margin: EdgeInsets.only(
                  left: LanguageChecker.isArabic(context) ? 0 : 15,
                  right: LanguageChecker.isArabic(context) ? 15 : 0),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedPrice == 0
                    ? AppColors.mainColor
                    : AppColors.mainColor.withAlpha(20),
              ),
              child: Text('search.highestPrice'.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: selectedPrice == 0
                          ? Colors.white
                          : AppColors.mainColor)),
            ),
          ),
          horizontalSpace(5),
          GestureDetector(
            onTap: () {
              setModalState(() {
                selectedPrice = 1;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedPrice == 1
                    ? AppColors.mainColor
                    : AppColors.mainColor.withAlpha(20),
              ),
              child: Text('search.lowestPrice'.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: selectedPrice == 1
                          ? Colors.white
                          : AppColors.mainColor)),
            ),
          )
        ],
      )
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
