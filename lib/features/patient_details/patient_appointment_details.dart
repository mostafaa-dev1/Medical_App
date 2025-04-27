import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/constants/preferances.dart';
import 'package:medical_system/core/helpers/extentions.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/routing/routes.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';
import 'package:medical_system/core/widgets/custom_button.dart';
import 'package:medical_system/core/widgets/custom_dropdown.dart';
import 'package:medical_system/core/widgets/stepper.dart';
import 'package:medical_system/features/appointments/data/models/appointments_model.dart';

class PatientAppointmentDetails extends StatefulWidget {
  const PatientAppointmentDetails(
      {super.key,
      required this.appointment,
      required this.user,
      required this.doctor});
  final UserModel user;
  final Appointment appointment;
  final Clinic doctor;

  @override
  State<PatientAppointmentDetails> createState() =>
      _PatientAppointmentDetailsState();
}

class _PatientAppointmentDetailsState extends State<PatientAppointmentDetails> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController problemController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? selectedGender;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = '${widget.user.firstName} ${widget.user.lastName}';
    ageController.text =
        (DateTime.now().difference(widget.user.dateOfBirth!).inDays / 365.25)
            .toInt()
            .toString();
    phoneController.text = widget.user.phone ?? '';
    selectedGender = widget.user.gender;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    problemController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("appointments.bookAppointment".tr(),
            style: Theme.of(context).textTheme.titleSmall),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.appointment.patient = Patient(
                  name: nameController.text,
                  age: int.parse(ageController.text),
                  phone: phoneController.text,
                  gender: selectedGender,
                  problem: problemController.text,
                );

                context.pushNamed(AppRoutes.reviewSummary, arguments: {
                  'appointment': widget.appointment,
                  'user': widget.user,
                  'doctor': widget.doctor
                });
              }
            },
            buttonName: 'appointments.next'.tr(),
            width: double.infinity,
            paddingVirtical: 5,
            height: 40,
            paddingHorizental: 10,
          ),
        ),
      ],
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppointmentStepper(
                  index: 1, text: 'appointments.patientDetails'.tr()),
              Padding(
                padding: const EdgeInsets.all(AppPreferances.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.mainColor,
                        ),
                      ),
                      child: Text(
                        'If you book for another person, please fill his details below',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    verticalSpace(10),
                    CustomTextFrom(
                      withhint: true,
                      hintText: 'appointments.name'.tr(),
                      controller: nameController,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'name is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    verticalSpace(20),
                    CustomTextFrom(
                      withhint: true,
                      hintText: 'appointments.age'.tr(),
                      controller: ageController,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'age is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    verticalSpace(20),
                    AppCustomDropDown(
                        initialItem:
                            'appointments.${selectedGender!.toLowerCase()}'
                                .tr(),
                        withHint: true,
                        list: [
                          'appointments.male'.tr(),
                          'appointments.female'.tr()
                        ],
                        width: double.infinity,
                        height: 50,
                        onChanged: (value) {
                          selectedGender = value;
                          return null;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'gender is required';
                          }
                          return null;
                        },
                        text: 'appointments.gender'.tr(),
                        hintText: 'appointments.gender'.tr()),
                    verticalSpace(20),
                    CustomTextFrom(
                      prefixText: '+20',
                      withhint: true,
                      hintText: 'appointments.phoneNumber'.tr(),
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'phone number is required';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(20),
                    CustomTextFrom(
                      maxLines: null,
                      withhint: true,
                      hintText: 'appointments.wahtIsYourProblem'.tr(),
                      controller: problemController,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'problem is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
