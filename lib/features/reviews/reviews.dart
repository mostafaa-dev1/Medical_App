import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '4.9 (4120 reviews)',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 35,
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
                  );
                },
              ),
            ),
            verticalSpace(20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainColor.withAlpha(10),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                              ),
                            ),
                            horizontalSpace(10),
                            Text(
                              'John Doe',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.mainColor,
                                  )),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.mainColor,
                                    size: 20,
                                  ),
                                  horizontalSpace(5),
                                  Text(
                                    '5.0',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(10),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        verticalSpace(10),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  index % 2 != 0
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: index % 2 == 0
                                      ? null
                                      : AppColors.secondaryColor,
                                )),
                            horizontalSpace(5),
                            Text(
                              '12',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Spacer(),
                            Text(
                              '2 days ago',
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
