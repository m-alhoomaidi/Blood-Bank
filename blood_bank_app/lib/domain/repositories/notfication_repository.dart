import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/usecases/send_notfication_.dart';
import 'package:dartz/dartz.dart';

abstract class SendNotficationRepository {
  Future<Either<Failure, Unit>> senNotficationToGroup(
      {required SendNotificationData sendNotificationData});
}
