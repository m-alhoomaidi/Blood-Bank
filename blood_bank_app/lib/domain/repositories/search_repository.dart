import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/donor.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Donor>>> searchForDonors({
    required String state,
    required String district,
    required String bloodType,
  });
}
