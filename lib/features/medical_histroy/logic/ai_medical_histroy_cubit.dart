import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';

part 'ai_medical_histroy_state.dart';

class AiMedicalHistroyCubit extends Cubit<AiMedicalHistroyState> {
  AiMedicalHistroyCubit() : super(AiMedicalHistroyInitial());

  // final _aiData = AiData();
  final _supabse = SupabaseServices();

//   List<Map<String, dynamic>> messages = [
//     {
//       "role": "model",
//       "parts": [
//         {
//           "text": '''
//  You are a medical assistant chatbot integrated into a healthcare Flutter app. Your role is to collect a patient's full medical history.

// 🩺 You must:
// - Create user medical histroy based on the user's answers.
// - response should be in markdown text format.
// {"question": "What is your full name?", "answer": "Sarah Mitchell"},
//     {"question": "What is your date of birth?", "answer": "1992-04-15"},
//     {"question": "What is your gender?", "answer": "Female"},
//     {"question": "What is your National ID or Patient ID?", "answer": "ID459302918"},
//     {"question": "What is your phone number?", "answer": "+1 555-236-7890"},
//     {"question": "What is your email address?", "answer": "sarah.mitchell@example.com"},
//     {"question": "What is your home address?", "answer": "123 Maple St, Springfield, IL"},
//     {"question": "Who should we contact in case of emergency?", "answer": "John Mitchell"},
//     {"question": "What is their relationship to you?", "answer": "Husband"},
//     {"question": "What is their phone number?", "answer": "+1 555-236-7891"},
//     {"question": "Do you have any chronic conditions?", "answer": "Yes"},
//     {"question": "Please list your chronic conditions.", "answer": "Asthma, Hypothyroidism"},
//     {"question": "Have you ever had any surgery?", "answer": "Yes"},
//     {"question": "Please describe the surgery and when it happened.", "answer": "Appendectomy in 2014"},
//     {"question": "Have you been hospitalized in the past?", "answer": "Yes"},
//     {"question": "What was the reason and when?", "answer": "Severe asthma attack, 2018"},
//     {"question": "Have you had any serious infections like Tuberculosis, Hepatitis, or COVID-19?", "answer": "Yes"},
//     {"question": "Please list them with approximate dates.", "answer": "COVID-19 in November 2020"},
//     {"question": "Have you had any major injuries?", "answer": "No"},
//     {"question": "Are you currently taking any medications?", "answer": "Yes"},
//     {"question": "Please list them with dosage and frequency.", "answer": "Levothyroxine 100 mcg daily, Albuterol inhaler as needed"},
//     {"question": "Have you taken any long-term medications in the past?", "answer": "Yes"},
//     {"question": "Please list them.", "answer": "Prednisone (short-term for asthma exacerbations)"},
//     {"question": "Do you have any allergies?", "answer": "Yes"},
//     {"question": "Please list them.", "answer": "Penicillin, Dust"},
//     {"question": "Does anyone in your family have a history of chronic or genetic diseases?", "answer": "Yes"},
//     {"question": "Please mention who and what conditions.", "answer": "Father: Type 2 Diabetes, Mother: Rheumatoid Arthritis"},
//     {"question": "Do you smoke?", "answer": "No"},
//     {"question": "Do you drink alcohol?", "answer": "Occasionally"},
//     {"question": "How often do you drink?", "answer": "1–2 times a month"},
//     {"question": "Do you use recreational drugs?", "answer": "No"},
//     {"question": "How would you describe your physical activity level?", "answer": "Moderate (walking 3–4 times/week)"},
//     {"question": "How many hours do you sleep per night on average?", "answer": "6–7 hours"},
//     {"question": "How would you describe your diet?", "answer": "Balanced, mostly home-cooked meals"},
//     {"question": "What is your current occupation?", "answer": "High school teacher"},
//     {"question": "Are you currently pregnant?", "answer": "No"},
//     {"question": "Are your menstrual cycles regular?", "answer": "Yes"},
//     {"question": "Are you using birth control?", "answer": "Yes"},
//     {"question": "Are you post-menopausal?", "answer": "No"},
//     {"question": "What is your height?", "answer": "165 cm"},
//     {"question": "What is your weight?", "answer": "68 kg"},
//     {"question": "Do you know your recent blood pressure reading?", "answer": "120/78 mmHg"},
//     {"question": "Do you know your recent blood sugar levels?", "answer": "Normal during last checkup"},
//     {"question": "Are you experiencing any current symptoms?", "answer": "Yes"},
//     {"question": "Please list your symptoms.", "answer": "Occasional shortness of breath, fatigue"},
//     {"question": "What are your current health goals?", "answer": "Improve stamina, better asthma control"},
//     {"question": "Would you like to receive health tips or doctor recommendations based on your answers?", "answer": "Yes"}

// 📥

//     ''',
//         }
//       ]
//     },
//   ];
  List<Map<String, dynamic>> questions = [
    {"type": "Essay", "question": "What is your height?"},
    {"type": "Essay", "question": "What is your weight?"},
    {
      "type": "Y&N",
      "question": "Do you have any chronic conditions?",
      "subQuestion": "Please list your chronic conditions."
    },
    {
      "type": "Y&N",
      "question": "Have you ever had any surgery?",
      "subQuestion": "Please describe the surgery and when it happened."
    },
    {
      "type": "Y&N",
      "question": "Have you been hospitalized in the past?",
      "subQuestion": "What was the reason and when?"
    },
    {
      "type": "Y&N",
      "question": "Have you had any serious infections?",
      "subQuestion": "Please list them with approximate dates.",
    },
    {
      "type": "Y&N",
      "question": "Have you had any major injuries?",
      "subQuestion": "Please Describe"
    },
    {
      "type": "Y&N",
      "question": "Are you currently taking any medications?",
      "subQuestion": "Please list them with dosage and frequency.",
    },
    {
      "type": "Y&N",
      "question": "Have you taken any long-term medications in the past?",
      "subQuestion": "Please list them.",
    },
    {
      "type": "Y&N",
      "question": "Do you have any allergies?",
      "subQuestion": "Please list them."
    },
    {
      "type": "Y&N",
      "question":
          "Does anyone in your family have a history of chronic or genetic diseases?",
      "subQuestion": "Please mention who and what conditions.",
    },
    {"type": "Y&N", "question": "Do you smoke?"},
    {
      "type": "Essay",
      "question": "How many hours do you sleep per night on average?",
    },
    {
      "type": "Essay",
      "question": "What is your current occupation?",
    },
    {
      "type": "Y&N",
      "question": "Are you experiencing any current symptoms?",
      "subQuestion": "Please list them.",
    },
  ];
  TextEditingController answerController = TextEditingController();
  TextEditingController subAnswerController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  int? yesOrno;
  int questionIndex = 0;
  String? answer;
  String? subAnswer;
  List<dynamic> answers = [];
  void addAnswer() {
    if (questionIndex == 0) {
      answers.add({"height": answer});
    } else if (questionIndex == 1) {
      answers.add({"weight": answer});
    } else {
      answers.add({
        "question": questions[questionIndex]["question"],
        "subQuestion": questions[questionIndex]["subQuestion"] ?? "",
        "answer": answer,
        "subAnswer": subAnswer ?? "",
      });
    }
    answer = null;
    subAnswer = null;
    answerController.clear();
    subAnswerController.clear();
    yesOrno = null;
    questionIndex++;
    log(answers.toString());
    emit(AddAnswer());
  }

  void yesOrnoSwitch(int index) {
    yesOrno = index;
    emit(YesORNo());
  }

  Future<void> uploadMedicalHistroy(String id) async {
    emit(UploadMedicalHistroyLoading());
    final response = await _supabse
        .setData(table: 'UsersInfo', data: {'history': answers, 'id': id});
    response.fold((l) {
      emit(UploadMedicalHistroyError(errMessage: l));
    }, (r) {
      emit(UploadMedicalHistroySuccess());
    });
  }

  Future<void> getMedicalHistory(String id) async {
    emit(GetMedicalHistoryLoading());
    final response = await _supabse.getDataWitheq('UsersInfo', '', 'id', id);
    response.fold((l) {
      emit(GetMedicalHistoryError());
    }, (r) {
      if (r.isEmpty) {
        emit(GetMedicalHistoryError());
        return;
      }
      answers = r[0]['history'];
      emit(GetMedicalHistorySuccess());
    });
  }
  // void addAiMessage(String message, String type, List<dynamic>? choices) {
  //   messages.add(
  //     {
  //       "role": "model",
  //       "parts": [
  //         {
  //           "text": message,
  //         }
  //       ]
  //     },
  //   );
  //   data.add(
  //     {
  //       "role": "model",
  //       "type": type,
  //       "message": message,
  //       "choices": choices,
  //     },
  //   );
  //   emit(AiMessageAdded());
  // }

  // int i = 0;

  // void addMessage({String? messge}) {
  //   if (messageController.text.isEmpty && messge == null) return;
  //   messages.add(
  //     {
  //       "role": "user",
  //       "parts": [
  //         {
  //           "text": messageController.text.isEmpty
  //               ? messge!
  //               : messageController.text,
  //         }
  //       ]
  //     },
  //   );
  //   data.add(
  //     {
  //       "role": "user",
  //       "type": "",
  //       "message":
  //           messageController.text.isEmpty ? messge! : messageController.text,
  //     },
  //   );
  //   emit(AiMessageAdded());

  //   sendMessage();

  //   messageController.clear();
  // }

  // String message = '';
  // Future<void> sendMessage() async {
  //   if (!await ConnectivityHelper.checkConnection()) {
  //     emit(NoInternetConnection());
  //     return;
  //   }
  //   emit(AiLoading());
  //   log('messages: $messages');
  //   final response = await _aiData.sendMessage(messages);
  //   response.fold((l) {
  //     log(l.toString());
  //     emit(AiError(errMessage: l));
  //   }, (r) {
  //     String completeMessage = '';
  //     log(r.toString());
  //     // Iterate through the response candidates and combine all parts of the response
  //     for (var element in r) {
  //       // Combine all parts into one string
  //       for (var part in element['candidates'][0]['content']['parts']) {
  //         completeMessage += part['text']; // Concatenate each part with a space
  //       }
  //     }
  //     message = completeMessage;
  //     // if (completeMessage.trim() == 'Finished') {
  //     //   for (int i = 0; i < data.length; i += 2) {
  //     //     medicalHistory.add({
  //     //       'question': data[i]['message'],
  //     //       'answer': data[i + 1]['message']
  //     //     });
  //     //   }
  //     //   log('medicalHistory: $medicalHistory');
  //     //   emit(AiFinished());
  //     //   addAiMessage(completeMessage.trim(), 'Finished', []);
  //     // } else {
  //     //   addAiMessage(completeMessage.trim(), '', []);
  //     //   medicalHistory.add({
  //     //     'question': completeMessage.trim(),
  //     //     'answer': messageController.text
  //     //   });
  //     // }
  //     // log(' completeMessage: ${completeMessage.trim()}');
  //     // dynamic message;
  //     // try {
  //     //   // Decode the response
  //     //   message = decode(completeMessage.trim());
  //     //   // Add the AI message to the chat history
  //     //   log('message: $message');
  //     //   log(message.toString());
  //     //   addAiMessage(message['message'], message['type'], message['choices']);
  //     //   if (message['type'] == 'Finished') {
  //     //     message['result'].forEach((element) {
  //     //       medicalHistory.add(element);
  //     //     });
  //     //     log('medicalHistory: $medicalHistory');
  //     //   }
  //     // } catch (e) {
  //     //   log(e.toString());
  //     //   // Add the AI message to the chat history
  //     //   addAiMessage(completeMessage, '', []);
  //     // }
  //     emit(AiSuccess());
  //   });
  // }

  // dynamic decode(String response) {
  //   try {
  //     // Decode the response
  //     dynamic decodedResponse = jsonDecode(response);
  //     log('decodedResponse: ${decodedResponse['message']}');
  //     return decodedResponse;
  //   } catch (e) {
  //     emit(AiError(errMessage: e.toString()));
  //   }
  //   return {};
  // }
}
