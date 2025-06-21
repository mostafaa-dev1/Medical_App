import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_system/features/medical_histroy/logic/ai_medical_histroy_cubit.dart';

class AiMedicalHistroy extends StatelessWidget {
  AiMedicalHistroy({super.key});
  final ScrollController scrollController = ScrollController();
  void _scrollToBottom() {
    if (scrollController.hasClients) {
      // Ensure that the controller is attached to the widget and scroll to the bottom
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiMedicalHistroyCubit, AiMedicalHistroyState>(
      listener: (context, state) {
        if (state is AiMessageAdded) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        return Scaffold(
          persistentFooterButtons: [],
          appBar: AppBar(
            title: Text(
              'AI Medical Histroy',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          // body: state is AiLoading
          //     ? Center(
          //         child: LoadingAnimationWidget.waveDots(
          //             color: AppColors.mainColor, size: 18),
          //       )
          //     : Container(
          //         padding: const EdgeInsets.all(10),
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: Theme.of(context).colorScheme.primary,
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Theme.of(context).colorScheme.shadow,
          //                 spreadRadius: 5,
          //                 blurRadius: 7,
          //                 offset: const Offset(
          //                     0, 3), // changes position of shadow
          //               ),
          //             ]),
          //         child: Column(
          //           children: [
          //             Expanded(
          //                 child: Markdown(
          //                     styleSheet: MarkdownStyleSheet.fromTheme(
          //                         Theme.of(context)),
          //                     styleSheetTheme:
          //                         MarkdownStyleSheetBaseTheme.material,
          //                     data: cubit.message,
          //                     ),
          //                     ),
          //           ],
          //         ),
          // )
        );
      },
    );
  }
}
