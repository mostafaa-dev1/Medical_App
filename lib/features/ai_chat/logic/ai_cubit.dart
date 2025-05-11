import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_system/core/constants/language_checker.dart';
import 'package:medical_system/core/models/doctor_model.dart';
import 'package:medical_system/core/networking/connectivity/connectivity_helper.dart';
import 'package:medical_system/features/ai_chat/data/ai_data/ai_data.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit() : super(AiInitial());
  final AiData _aiData = AiData();
  TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {
      "role": "model",
      "parts": [
        {
          "text": '''--- START OF PROMPT ---

You are a medical AI chatbot named Delma designed to assist users in identifying potential doctor specializations based on their symptoms. Your responses should be formatted as text that resembles JSON. This means the output should be a string formatted as if it were a JSON object, but it will not be interpreted as actual JSON.

Key Behaviors:

Language Adaptation: If the user communicates in Arabic, respond in Arabic. Otherwise, respond in English.

Inquisitive Nature: You must ask at least 5 questions to thoroughly understand the patient's symptoms before suggesting a doctor's specialization. Do not rely solely on the provided knowledge base. Feel free to ask questions beyond the symptoms explicitly listed.

Knowledge Base as a Guide: The provided knowledge base serves as a helpful reference, not a strict rulebook. It helps you identify potential diseases and related symptoms to explore, but you can (and should) ask questions about other relevant symptoms not explicitly listed there.

Contextual Awareness: Maintain context throughout the conversation. Remember the user's previously mentioned symptoms and use them to guide your subsequent questions.

Focused Scope: You are strictly a medical AI assistant.

Dynamic Welcome Message: Vary the wording of the welcome message each time it is used. Examples: "Greetings! I am Delma, your medical assistant. How can I help you today?", "Hello! Delma here, ready to assist with your health concerns.", "Welcome! Delma at your service for medical advice. What brings you in today?".

Text-Based "JSON" Format: Responses must be formatted as text that looks like JSON. This means the output should be a string enclosed in quotation marks and formatted with key-value pairs. For example:
{"type": "Question", "message": "Do you have a fever?" } 

Don't add any thing with JSON, Just the JSON format response

Response Guidelines:

1. User Provides a Symptom:

Ask a relevant follow-up question to gather more details. The knowledge base can suggest questions, but don't limit yourself to it. Explore related symptoms!

Format:
{"type": "Question", "message": "..."} 

2. User Asks for a Doctor for a Specific Disease:

You CANNOT directly answer this question until you have asked at least 5 questions about the user's symptoms. Respond with an appropriate question to start the symptom-gathering process.

Example response (in English): {"type": "Question", "message": "To help me understand, could you describe the symptoms you are experiencing?"} 

Example response (in Arabic): {"type": "Question", "message": "لمساعدتي في الفهم، هل يمكنك وصف الأعراض التي تعاني منها؟"} 

3. User Greets You:

Respond with a welcoming message that includes the name "Delma" and acknowledges your role. Choose your own creative wording, but keep it professional and medical-focused. Examples (choose randomly):

{"type": "Message", "message": "Greetings! I am Delma, your medical assistant. How can I help you today?"}

{"type": "Message", "message": "Hello! Delma here, ready to assist with your health concerns."}

{"type": "Message", "message": "Welcome! Delma at your service for medical advice. What brings you in today?"}

{"type": "Message", "message": "أهلاً بك! أنا دلمه، مساعدك الطبي. كيف يمكنني مساعدتك اليوم؟"}

{"type": "Message", "message": "مرحباً! دلمه هنا، مستعدة للمساعدة في استفساراتك الصحية."}

4. User Asks a Non-Medical Question:

Respond with a message that gently redirects them to your medical purpose, using wording you choose.
Don't use double quotes in the first of message.

Example: {"type": "Message", "message": "My expertise lies in assisting with medical inquiries. How can I help you with your health today?"}

Example: {"type": "Message", "message": "أنا متخصص فقط في المساعدة في الاستفسارات الطبية. كيف يمكنني مساعدتك في صحتك اليوم؟"}

5. After Asking at Least 5 Questions and Gaining Sufficient Understanding of Symptoms:

Only then can you suggest a doctor specialization. Use the knowledge base to inform your decision, but also consider your broader medical knowledge (even if not explicitly in the knowledge base).

Format:
{"type": "Spciality", "message": "..." } 
The message should include the spciality suggestion only.
Even if th user speak in Arabic, the speciality suggestion message should be in English.
Example: 
{"type": "Spciality", "message": "Neurologist" } 


Your Knowledge Base (in JSON format - use this as a guide):

```json
{
"Sheet1": [
{
"Symptoms": "Runny nose and nasal congestion سيلان الأنف واحتقان الأنف",
"disease": "Common Cold الزكام (البرد )",
"Specialization": "Otorhinolaryngologist أخصائي الأنف والأذن والحنجرة"
},
{
"Symptoms": "Dry cough.\nRunny nose.\nEye pain.\nPoor appetite.\nHeadache.\nVomiting and diarrhea, especially in children and infants.\nسعال جاف، سيلان الأنف، ألم في العين، فقدان الشهية، صداع، التقيؤ والإسهال خاصة عند الأطفال والرضع",
"disease": "Influenza (Flu) الإنفلونزا",
"Specialization": "Infectious Diseases Physician/Internist أخصائي الأمراض المعدية / طبيب باطني"
},
{
"Symptoms": "Smell or taste sensation.\nGeneral fatigue.\nDizziness.\nDry cough.\nFever.\nNasal congestion.\nHead .\nsuddenly.\nفقدان حاسة الشم أو التذوق، إرهاق عام، دوخة، سعال جاف، حمى، احتقان الأنف، صداع مفاجئ",
"disease": "COVID-19 كوفيد-19",
"Specialization": "Pulmonologist / Infectious Disease Physician أخصائي الأمراض الرئوية / أخصائي الأمراض المعدية"
},
{
"Symptoms": "Pale stool.\nAbdominal pain.\nChronic.\nVomiting.\nPaul Cross.\nPain.\nJaundice is yellowing of the skin and eyes.\nبراز شاحب، ألم في البطن، مزمن، تقيؤ، ألم متقاطع، ألم، اليرقان",
"disease": "Hepatitis التهاب الكبد",
"Specialization": "Gastroenterologist / Internistأخصائي أمراض الجهاز الهضمي / طبيب باطني"
},
{
"Symptoms": "High body temperature.\nSwelling of the lymph nodes.\nRash.\nHigh body temperature.\nارتفاع درجة حرارة الجسم، تورم العقد الليمفاوية، طفح جلدي، ارتفاع درجة الحرارة\n",
"disease": "HIV/AIDS فيروس نقص المناعة البشرية/الإيدز",
"Specialization": "Infectious Disease Physician/Internistأخصائي الأمراض المعدية / طبيب باطني"
},
{
"Symptoms": "Cough with phlegm or mucus that may contain blood\nChest pain during attacks.\nRapid heart rate.\nFeeling tired and exhausted.\nسعال مع بلغم أو مخاط قد يحتوي على دم، ألم في الصدر أثناء النوبات، تسارع ضربات القلب، الشعور بالتعب والإرهاق",
"disease": "Pneumonia الالتهاب الرئوي",
"Specialization": "Pulmonologist / Internistأخصائي الأمراض الرئوية / طبيب باطني"
},
{
"Symptoms": "Thirst.\nUrinating frequently and often. \nExtreme hunger.\nBlurred vision.\nHealing and healing of wounds Ninja.\nFrequent infections in: relieve, relieve pain, or relieve muscle pain.\nالعطش، التبول المتكرر والمستمر، الجوع المفرط، رؤية ضبابية، بطء شفاء الجروح، الالتهابات المتكررة",
"disease": "Diabetes داء السكري",
"Specialization": "Endocrinologist/Internist أخصائي الغدد الصماء / طبيب باطني"
},
{
"Symptoms": "Shortness of breath, especially during physical activity.\nWheezing.\nChest tightness.\nA chronic cough that may produce clear, white, yellow, or greenish mucus\nSwelling in the ankles, feet, or legs.\nضيق في التنفس، صفير في الصدر، ضيق في الصدر، سعال مزمن مع بلغم، تورم الكاحلين أو القدمين أو الساقين",
"disease": "Chronic Obstructive Pulmonary Disease مرض الانسداد الرئوي المزمن",
"Specialization": "Pulmonologist/Internist أخصائي الأمراض الرئوية / طبيب باطني"
},
{
"Symptoms": "Chest tightness or pain.\nTrouble sleeping due to shortness of breath.\nCoughing, wheezing, or crackling when breathing\nضيق في الصدر، صعوبة النوم بسبب ضيق التنفس، السعال أو الصفير عند التنفس",
"disease": "Asthma الربو",
"Specialization": "Pulmonologistأخصائي الأمراض الرئوية"
},
{
"Symptoms": "Chronic abdominal pain.\nChronic diarrhea.\nChronic constipation.\nAlternating diarrhea and constipation.\nIncreased gas.\nAbdominal bloating.\nBleeding from the rectum.\nألم مزمن في البطن، إسهال مزمن، إمساك مزمن، زيادة الغازات، انتفاخ البطن، نزيف من المستقيم",
"disease": "Irritable Bowel Syndrome متلازمة القولون العصبي",
"Specialization": "Gastroenterologist/Internist أخصائي أمراض الجهاز الهضمي / طبيب باطني"
},
{
"Symptoms": "Fever.\nHeadache.\nSore throat.\nFeeling weak.\nFatigue and loss of appetite\nThe chickenpox rash usually appears one to two days after the first symptoms appear.\nحمى، صداع، التهاب الحلق، الشعور بالضعف، الإرهاق، فقدان الشهية، طفح جدري الماء",
"disease": "Chickenpox جدري الماء",
"Specialization": "Dermatologist / Pediatrician أخصائي الجلدية / طبيب أطفال"
},
{
"Symptoms": "Pale skin. Rapid, irregular heartbeat.\nChanges in cognitive status.\nCold hands and feet\nMyocardial infarction.\nجلد شاحب، نبض سريع وغير منتظم، تغيرات في الإدراك، برودة اليدين والقدمين، احتشاء عضلة القلب",
"disease": "anemia (الانيميا ) فقر الدم",
"Specialization": "Hematologist / Internist أخصائي أمراض الدم / طبيب باطني"
},
{
"Symptoms": "Painless bleeding during a bowel movement, sometimes with a little bright red blood on toilet paper or in the toilet bowl.\nItching or irritation in the anal area.\nPain or discomfort.\nVisible hemorrhoids that protrude outside the anus.\nSwelling around the anus.\nA painful or tender bump near the anus.\nLeakage of stool.\nنزيف غير مؤلم أثناء التبرز، حكة أو تهيج في منطقة الشرج، ألم أو انزعاج، بواسير ظاهرة، تورم حول فتحة الشرج",
"disease": "Hemorrhoids البواسير",
"Specialization": "General Surgeon / Gastroenterologist/lnternist جراح عام / أخصائي أمراض الجهاز الهضمي / طبيب باطني"
},
{
"Symptoms": "Red eyes.\nConstant and annoying itching.\nA feeling of sand in the eyes or a foreign body that causes itching and cannot be located.\nPeeling and swelling of the eyelids.\nBlurred and blurred vision.\nPusy discharge.\nWatery eyes.\nAches.\nاحمرار العينين، حكة مزعجة، شعور بوجود رمل في العين، تقشر الجفون، رؤية ضبابية، إفرازات قيحية",
"disease": "Eye Infections التهابات العين",
"Specialization": "Ophthalmologist أخصائي العيون"
},
{
"Symptoms": "Mucus formation around the eye.\nEye sensitivity to pine, or wind.\nAging.\nTo be able to keep the eye.\nFeeling tired in the eye even in the case of thermal reading for the reading period.\nBlurred eyes.\nSensitivity to light.\nConstant tears.\nSecond vision.\nEyelids resort to electronic cigarettes when waking up.\nEye pain from sunglasses.\nتكون المخاط حول العين، حساسية العين، إرهاق العين، ازدواج الرؤية، ألم العين من النظارات الشمسية",
"disease": "Dry Eyes جفاف العين",
"Specialization": "Ophthalmologist أخصائي العيون"
},

    ''',
        }
      ]
    },
  ];

  void init(BuildContext context) {
    if (LanguageChecker.isArabic(context)) {
      messages.add(
        {
          "role": "user",
          "parts": [
            {
              "text": 'مرحبا',
            }
          ]
        },
      );
    } else {
      messages.add(
        {
          "role": "user",
          "parts": [
            {
              "text": 'Hello',
            }
          ]
        },
      );
    }
    sendMessage();
  }

  List<Map<String, dynamic>> data = [];
  void addMessage() {
    if (messageController.text.isEmpty) return;
    messages.add(
      {
        "role": "user",
        "parts": [
          {
            "text": messageController.text,
          }
        ]
      },
    );
    data.add(
      {
        "role": "user",
        "type": "",
        "parts": [
          {
            "text": messageController.text,
          }
        ]
      },
    );
    emit(AiMessageAdded());

    sendMessage();
    messageController.clear();
  }

  /// Adds a message from the AI to the chat history.
  ///
  /// This function takes a [message] and a [type] as parameters and adds the
  /// message to the chat history with the given [type]. It also emits [AiMessageAdded]
  /// to notify the UI that a new message has been added.
  void addAiMessage(String message, String type) {
    messages.add(
      {
        "role": "model",
        "parts": [
          {
            "text": message,
          }
        ]
      },
    );
    data.add(
      {
        "role": "model",
        "type": type,
        "parts": [
          {
            "text": message,
          }
        ]
      },
    );
    emit(AiMessageAdded());
  }

  String messageType = '';

  /// Sends the user's message to the AI and updates the state with the AI's response.
  ///
  /// This function will emit [AiLoading] when the message is sent and then
  /// either [AiError] if the server returns an error or [AiSuccess] if the
  /// server returns a response from the AI.
  ///
  /// If the AI's response is a Spciality, it will be sent to the server to
  /// fetch the list of doctors with that Spciality.
  Future<void> sendMessage() async {
    if (!await ConnectivityHelper.checkConnection()) {
      emit(NoInternetConnection());
      return;
    }
    emit(AiLoading());
    final response = await _aiData.sendMessage(messages);
    response.fold((l) {
      emit(AiError(errMessage: l));
    }, (r) {
      String completeMessage = '';

      // Iterate through the response candidates and combine all parts of the response
      for (var element in r) {
        // Combine all parts into one string
        for (var part in element['candidates'][0]['content']['parts']) {
          completeMessage += part['text']; // Concatenate each part with a space
        }
      }
      log(' completeMessage: $completeMessage');
      dynamic message;

      try {
        message = decode(completeMessage);

        log('message: ${message['message']}');
        // addAiMessage(message.toString());
        addAiMessage(message['message'], message['type']);
        if (message['type'] == 'Spciality') {
          messageType = 'Spciality';
          data.add({"role": "list"});
          fitchDoctors(message['message']);
        }
      } catch (e) {
        addAiMessage(completeMessage, '');
        log(e.toString());
      }
      // addAiMessage(r);
      emit(AiSuccess());
    });
  }

  dynamic decode(String response) {
    try {
      dynamic decodedResponse = jsonDecode(response);
      log('decodedResponse: ${decodedResponse['message']}');
      return decodedResponse;
    } catch (e) {
      log(e.toString());
    }
    return {};
  }

  Clinics doctors = Clinics();

  /// Fetches the list of doctors with the given [spciality].
  ///
  /// This function emits [FitchDoctorsLoading] when it is called and then
  /// either [FitchDoctorsError] if the server returns an error or
  /// [FitchDoctorsSuccess] if the server returns a response from the AI.
  ///
  /// If the device's location is available, it sorts the list of doctors by
  /// distance.
  ///
  /// If the device's location is not available, it does not sort the list of
  /// doctors.
  Future<void> fitchDoctors(String spciality) async {
    emit(FitchDoctorsLoading());
    final response = await _aiData.fitchDoctors(spciality);
    response.fold((l) {
      emit(FitchDoctorsError(errMessage: l));
    }, (r) async {
      Position? userPosition = await _getUserLocation();
      log(userPosition.toString());
      List<Map<String, dynamic>> sortedDoctors = [];
      // Step 3: Sort Doctors by Distance
      if (userPosition != null) {
        log('with location');
        sortedDoctors = _sortDoctorsByDistance(
            userPosition.latitude, userPosition.longitude, r);
        doctors = Clinics.fromJson(sortedDoctors);
      } else {
        doctors = Clinics.fromJson(r);
      }
      doctors = Clinics.fromJson(r);

      // doctors = DoctorsList.fromJson(r);
      emit(FitchDoctorsSuccess());
    });
  }

  List<Map<String, dynamic>> _sortDoctorsByDistance(
      double userLat, double userLng, List<Map<String, dynamic>> doctors) {
    doctors.sort((a, b) {
      double distanceA = Geolocator.distanceBetween(userLat, userLng,
          a['lattitude'].toDouble(), a['longitude'].toDouble());
      double distanceB = Geolocator.distanceBetween(userLat, userLng,
          b['lattitude'].toDouble(), b['longitude'].toDouble());
      return distanceA.compareTo(distanceB); // Sort by nearest
    });

    return doctors;
  }

  Position? userPosition;
  DateTime? lastLocationCheckTime;
  Future<Position?> _getUserLocation() async {
    // Check if the location is already fetched and not too old
    if (userPosition != null &&
        lastLocationCheckTime != null &&
        DateTime.now().difference(lastLocationCheckTime!).inMinutes < 5) {
      return userPosition;
    } else {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // await Geolocator.openLocationSettings();
        // serviceEnabled = await Geolocator.isLocationServiceEnabled();
        // if (!serviceEnabled) {
        // }
        emit(LocationError(errMessage: "dialog.locationDisabled"));
        return null;
      }

      // Request permission if not granted
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError(errMessage: 'dialog.locationDenied'));
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError(errMessage: "dialog.locationDeniedForever"));
        //return Future.error('Location permissions are permanently denied');
        return null;
      }
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      userPosition = position;
      lastLocationCheckTime = DateTime.now();

      // Get current position
      return position;
    }
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }
}
