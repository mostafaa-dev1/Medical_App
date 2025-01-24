import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/features/onBoarding/widgets/onBoarding_item.dart';
import 'package:medical_system/features/onBoarding/widgets/top_logo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

late PageController _pageController;

class _OnBoardingState extends State<OnBoarding> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TopLogo(),
              Expanded(
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      int realIndex = index + 1;
                      return OnBoardItem(
                        part1: 'onBoard.part1$realIndex',
                        part2: 'onBoard.part2$realIndex',
                        part3: 'onBoard.part3$realIndex',
                        part4: 'onBoard.part4$realIndex',
                        description: 'onBoard.description$realIndex',
                        image: 'assets/images/onboard/onboard$realIndex.svg',
                      );
                    },
                    itemCount: 3,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              ),
              Row(
                textDirection: ui.TextDirection.ltr,
                children: [
                  SmoothPageIndicator(
                    textDirection: ui.TextDirection.ltr,
                    controller: _pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey[200]!,
                      activeDotColor: AppColors.secondaryColor,
                      dotHeight: 6,
                      dotWidth: 10,
                      expansionFactor: 4,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 60,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shape: CircleBorder()),
                      onPressed: () {
                        if (_pageController.page == 2) {
                          context.pushNamed(AppRoutes.login);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: Center(
                        child: Icon(
                          IconBroken.Arrow___Right,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
