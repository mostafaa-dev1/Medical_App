import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';

class HeartRate2 extends StatefulWidget {
  const HeartRate2({super.key});

  @override
  State<HeartRate2> createState() => _HeartRate2State();
}

class _HeartRate2State extends State<HeartRate2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isPlaying = false;
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  Timer? countdownTimer;
  int remainingSeconds = 60;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    countdownTimer?.cancel();
  }

  void _toggleAnimation() {
    if (isPlaying) {
      _controller.stop();
      stopCountdown();
    } else {
      _controller.repeat();
      startCountdown();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void startCountdown() {
    remainingSeconds = 60;
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          timer.cancel();
          _toggleAnimation(); // stop measuring automatically
        }
      });
    });
  }

  void stopCountdown() {
    countdownTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'heartRate.heartRate'.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPreferances.padding),
              child: Column(
                children: [
                  !isPlaying
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'How to measure ?',
                            ),
                            horizontalSpace(5),
                            Icon(
                              IconBroken.Info_Circle,
                              color: AppColors.mainColor,
                            ),
                          ],
                        )
                      : HeartBPMDialog(
                          context: context,
                          showTextValues: true,
                          borderRadius: 10,
                          cameraWidgetHeight: 80,
                          cameraWidgetWidth: 80,
                          onRawData: (value) {
                            setState(() {
                              if (data.length >= 100) data.removeAt(0);
                              data.add(value);
                            });
                            // chart = BPMChart(data);
                          },
                          onBPM: (value) => setState(() {
                            if (bpmValues.length >= 100) bpmValues.removeAt(0);
                            bpmValues.add(SensorValue(
                                value: value.toDouble(), time: DateTime.now()));
                          }),
                        ),
                  isPlaying
                      ? Text(
                          'Measuring... (${(((60 - remainingSeconds) / 60) * 100).toInt()}%)',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      : SizedBox(),
                  verticalSpace(10),
                  isPlaying
                      ? Text(
                          'Measuring your heart rate, please hold on',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      : SizedBox(),
                  verticalSpace(20),
                  GestureDetector(
                    onTap: _toggleAnimation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Lottie.asset(
                          'assets/images/rate.json',
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller.duration = composition.duration;
                          },
                        ),
                        !isPlaying
                            ? Column(
                                children: [
                                  Text(
                                    'Start',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Colors.white, fontSize: 30),
                                  ),
                                  verticalSpace(5),
                                  Text(
                                    'Tap to measure',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                  verticalSpace(30),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    bpmValues.isNotEmpty
                                        ? bpmValues.last.value
                                            .toInt()
                                            .toString()
                                        : '0',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Colors.white, fontSize: 30),
                                  ),
                                  verticalSpace(5),
                                  Text(
                                    'BPM',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  isPlaying
                      ? LinearProgressIndicator(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Colors.grey.shade300,
                          value: (60 - remainingSeconds) / 60,
                          minHeight: 10,
                        )
                      : SizedBox(),
                ],
              ),
            ),
            // isPlaying && data.isNotEmpty
            //     ? Container(
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //           color: AppColors.secondaryColor.withAlpha(50),
            //         )),
            //         height: 100,
            //         child: BPMChart(
            //           data,
            //         ),
            //       )
            //     : SizedBox(),
            isPlaying ? Spacer() : SizedBox(),
            isPlaying && bpmValues.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.secondaryColor.withAlpha(40),
                          AppColors.mainColor.withAlpha(10),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      // border: Border.symmetric(
                      //   horizontal: BorderSide(
                      //     width: 1,
                      //     color: AppColors.secondaryColor,
                      //   ),
                      // ),
                    ),
                    constraints: BoxConstraints.expand(height: 100),
                    child: BPMChart(
                      bpmValues,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
