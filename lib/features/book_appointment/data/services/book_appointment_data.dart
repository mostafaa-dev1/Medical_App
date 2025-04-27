import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/book_appointment/data/repo/book_appointment_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookAppointmentData extends BookAppointmentRepo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getAppointmentTimes(
      {required String doctorId, required String date}) {
    return _supabaseServices.getDataWithThreeeq(
      table: 'Appointments',
      query: '*',
      eqKey1: 'doctor_id',
      eqValue1: doctorId,
      eqKey2: 'type',
      eqValue2: 'Upcoming',
      eqKey3: 'date',
      eqValue3: date,
    );
  }

  Future<Either<String, List<Map<String, dynamic>>>> getAppointmentTimes2({
    required String doctorId,
    required String start,
    required String end,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('appointments')
          .select()
          .eq('doctor_id', doctorId)
          .eq('type', 'Upcoming')
          .gte('date', start)
          .lt('date', end);

      if (response.isNotEmpty) {
        return Left('No data found');
      }

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
