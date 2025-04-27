import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/ai_chat/data/repo/ai_repo.dart';

class AiData extends AiRepo {
  String apiKey = "AIzaSyA43KTy8q3wzA_qlhi4xg2e41Aii0AtiOg";
  final _supabaseServices = SupabaseServices();

  AiData();
  @override
  Future<Either<String, List<dynamic>>> sendMessage(
      List<Map<String, dynamic>> messages) async {
    String modelId = "gemini-2.0-flash";

    String apiUrl =
        "https://generativelanguage.googleapis.com/v1beta/models/$modelId:streamGenerateContent?key=$apiKey";

    // Define system message for context
    final Map<String, dynamic> requestBody = {"contents": messages};

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return Right(jsonDecode(response.body));
      } else {
        return Left("Error: ${response.body}");
      }
    } catch (e) {
      return Left("Exception: $e");
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> fitchDoctors(
      String speciality) {
    return _supabaseServices.getDataWithFilters(
        'Clinics', '*,Doctors!inner(*), DoctorsInfo(*)',
        specialty: speciality);
  }
}
