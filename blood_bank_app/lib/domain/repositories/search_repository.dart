import 'package:dartz/dartz.dart';

import '../../domain/entities/donor.dart';
import '../../domain/entities/blood_center.dart';
import '../../core/error/failures.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Donor>>> searchForDonors({
    required String state,
    required String district,
    required String bloodType,
  });
  Future<Either<Failure, List<BloodCenter>>> searchForCenters({
    required String state,
    required String district,
    required String bloodType,
  });
}
