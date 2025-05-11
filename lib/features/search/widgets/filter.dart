// import 'package:flutter/material.dart';
// import 'package:medical_system/core/helpers/spacing.dart';



//   Widget filterHeaderText(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Text(
//         text,
//         style: Theme.of(context).textTheme.bodyLarge,
//       ),
//     );
//   }

//   Widget spcialityFilter(void Function(void Function()) setModalState) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         filterHeaderText(
//           'search.speciality'.tr(),
//         ),
//         verticalSpace(5),
//         SizedBox(
//           height: 30,
//           width: double.infinity,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: Specialities.list.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   setModalState(() {
//                     _selectedSpeciality = index;
//                   });
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   margin: EdgeInsets.only(
//                       left: LanguageChecker.isArabic(context)
//                           ? 0
//                           : index == 0
//                               ? 15
//                               : 5,
//                       right: LanguageChecker.isArabic(context)
//                           ? index == 0
//                               ? 15
//                               : 5
//                           : 0),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 5,
//                   ),
//                   decoration: BoxDecoration(
//                     color: _selectedSpeciality == index
//                         ? AppColors.mainColor
//                         : AppColors.mainColor.withAlpha(20),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(Specialities.list[index].tr(),
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             color: _selectedSpeciality == index
//                                 ? Colors.white
//                                 : AppColors.mainColor,
//                           )),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget ratingFilter(void Function(void Function()) setModalState) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         filterHeaderText(
//           'search.rating'.tr(),
//         ),
//         verticalSpace(5),
//         SizedBox(
//           height: 30,
//           width: double.infinity,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: _rating.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   setModalState(() {
//                     _selectedRating = index;
//                   });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(
//                       left: LanguageChecker.isArabic(context)
//                           ? 0
//                           : index == 0
//                               ? 15
//                               : 5,
//                       right: LanguageChecker.isArabic(context)
//                           ? index == 0
//                               ? 15
//                               : 5
//                           : 0),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 15,
//                     vertical: 5,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: _selectedRating == index
//                         ? AppColors.mainColor
//                         : AppColors.mainColor.withAlpha(20),
//                   ),
//                   child: Row(
//                     children: [
//                       _rating[index] == 'All'
//                           ? SizedBox()
//                           : Icon(
//                               Icons.star,
//                               color: _selectedRating == index
//                                   ? Colors.white
//                                   : AppColors.mainColor,
//                               size: 18,
//                             ),
//                       _rating[index] == 'All' ? SizedBox() : horizontalSpace(5),
//                       Text(
//                           _rating[index] == 'All'
//                               ? 'search.all'.tr()
//                               : Format.formatNumber(
//                                   int.parse(_rating[index]), context),
//                           style:
//                               Theme.of(context).textTheme.bodySmall!.copyWith(
//                                     color: _selectedRating == index
//                                         ? Colors.white
//                                         : AppColors.mainColor,
//                                   )),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget priceFilter(void Function(void Function()) setModalState) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       filterHeaderText(
//         'search.price'.tr(),
//       ),
//       verticalSpace(5),
//       Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               setModalState(() {
//                 selectedPrice = 0;
//               });
//             },
//             child: Container(
//               height: 30,
//               margin: EdgeInsets.only(
//                   left: LanguageChecker.isArabic(context) ? 0 : 15,
//                   right: LanguageChecker.isArabic(context) ? 15 : 0),
//               padding: EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 5,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: selectedPrice == 0
//                     ? AppColors.mainColor
//                     : AppColors.mainColor.withAlpha(20),
//               ),
//               child: Text('search.highestPrice'.tr(),
//                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                       color: selectedPrice == 0
//                           ? Colors.white
//                           : AppColors.mainColor)),
//             ),
//           ),
//           horizontalSpace(5),
//           GestureDetector(
//             onTap: () {
//               setModalState(() {
//                 selectedPrice = 1;
//               });
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 5,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: selectedPrice == 1
//                     ? AppColors.mainColor
//                     : AppColors.mainColor.withAlpha(20),
//               ),
//               child: Text('search.lowestPrice'.tr(),
//                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                       color: selectedPrice == 1
//                           ? Colors.white
//                           : AppColors.mainColor)),
//             ),
//           )
//         ],
//       )
//     ]);
//   }

//   Widget governmentFilter(void Function(void Function()) setModalState) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       filterHeaderText(
//         'search.government'.tr(),
//       ),
//       verticalSpace(5),
//       SizedBox(
//           height: 30,
//           width: double.infinity,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: Governments.governments.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   setModalState(() {
//                     _selectedGovernment = index;
//                   });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(
//                       left: LanguageChecker.isArabic(context)
//                           ? 0
//                           : index == 0
//                               ? 15
//                               : 5,
//                       right: LanguageChecker.isArabic(context)
//                           ? index == 0
//                               ? 15
//                               : 5
//                           : 0),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 15,
//                     vertical: 5,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: _selectedGovernment == index
//                         ? AppColors.mainColor
//                         : AppColors.mainColor.withAlpha(20),
//                   ),
//                   child: Text(
//                       Governments.governments[index] == 'government.All'
//                           ? 'search.all'.tr()
//                           : Governments.governments[index].tr(),
//                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             color: _selectedGovernment == index
//                                 ? Colors.white
//                                 : AppColors.mainColor,
//                           )),
//                 ),
//               );
//             },
//           ))
//     ]);
//   }