import 'package:flutter/material.dart';

class DoctorAvailabilityModel {
  String day;
  TimeOfDay startTime;
  TimeOfDay endTime;
  int examinationDuration;
  DoctorAvailabilityModel({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.examinationDuration,
  });
}
