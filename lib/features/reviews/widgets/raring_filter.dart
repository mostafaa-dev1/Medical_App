import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class RatingFilter extends StatefulWidget {
  const RatingFilter({super.key});

  @override
  State<RatingFilter> createState() => _RatingFilterState();
}

class _RatingFilterState extends State<RatingFilter> {
  final List<String> _rating = [
    'All',
    '5',
    '4',
    '3',
    '2',
    '1',
  ];

  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _rating.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedRating = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 2,
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
                  Text(_rating[index],
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
    );
  }
}
