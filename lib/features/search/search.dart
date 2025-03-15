import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<String> searchList = [
    'Dentist',
    'Cardiologist',
    'Surgeon',
    'Neurologist',
    'Orthopedic Surgeon',
    'Gynecologist',
    'Pediatrician',
    'Dermatologist',
  ];
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
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: CustomTextFrom(
                      suffixIcon: IconButton(
                          icon: Icon(
                            IconBroken.Filter,
                            color: AppColors.mainColor,
                            size: 20,
                          ),
                          onPressed: () {
                            showBottomSheet();
                          }),
                      focusNode: _focusNode,
                      hintText: 'Search',
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                searchList.length,
                (index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondaryColor.withAlpha(20),
                    border: Border.all(
                      color: AppColors.secondaryColor.withAlpha(50),
                    ),
                  ),
                  child: Text(
                    searchList[index],
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: context,
      showDragHandle: true,
      elevation: 2,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) => Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 350,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Text(
                  'Filter',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                verticalSpace(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spcialityFilter(setModalState),
                    verticalSpace(10),
                    ratingFilter(setModalState),
                    verticalSpace(50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          buttonName: 'Reset',
                          onPressed: () {},
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
                            buttonName: 'Submit',
                            onPressed: () {},
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

  Widget spcialityFilter(void Function(void Function()) setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Speciality',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        verticalSpace(10),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: searchList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setModalState(() {
                      _selectedSpeciality = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedSpeciality == index
                          ? AppColors.mainColor
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.mainColor,
                      ),
                    ),
                    child: Text(searchList[index],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: _selectedSpeciality == index
                                  ? Colors.white
                                  : AppColors.mainColor,
                            )),
                  ),
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
        Text(
          'Rating',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        verticalSpace(10),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _rating.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    setModalState(() {
                      _selectedRating = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _selectedRating == index
                          ? AppColors.mainColor
                          : Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: AppColors.mainColor,
                      ),
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
                                size: 20,
                              ),
                        _rating[index] == 'All'
                            ? SizedBox()
                            : horizontalSpace(5),
                        Text(_rating[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: _selectedRating == index
                                      ? Colors.white
                                      : AppColors.mainColor,
                                )),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
