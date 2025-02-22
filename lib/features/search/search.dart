import 'package:flutter/material.dart';
import 'package:medical_system/core/helpers/spacing.dart';
import 'package:medical_system/core/themes/colors.dart';
import 'package:medical_system/core/widgets/app_text_form.dart';

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
}
