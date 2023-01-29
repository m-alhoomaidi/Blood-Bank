// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/repositories/notfication_repository.dart';

class SendNotficationUseCase {
  final SendNotficationRepository sendNotficationRepository;
  SendNotficationUseCase({
    required this.sendNotficationRepository,
  });

  Future<Either<Failure, Unit>> call(
      {required SendNotficationData sendNotficationData}) async {
    return sendNotficationRepository.senNotficationToGroup(
        sendNotficationData: sendNotficationData);
  }
}

class SendNotficationData {
  List<String> listToken;
  String title;
  String body;
  SendNotficationData({
    required this.listToken,
    required this.title,
    required this.body,
  });
}
