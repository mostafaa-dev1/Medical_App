import 'package:dartz/dartz.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/features/home/ui/widgets/offers/data/repo/offers_reo.dart';

class OffersData extends OffersReo {
  final _supabaseServices = SupabaseServices();
  @override
  Future<Either<String, List<Map<String, dynamic>>>> getOffers(
      {required String provider}) {
    return _supabaseServices.getDataWitheq(
        'Offers', '*,Doctors(*)', 'provider', provider);
  }
}
