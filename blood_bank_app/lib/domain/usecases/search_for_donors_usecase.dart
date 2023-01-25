// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:blood_bank_app/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchForDonorsUseCase {
  final SearchRepository searchRepository;
  SearchForDonorsUseCase({
    required this.searchRepository,
  });
  Future<Either<Failure, List<Donor>>> call({
    required String state,
    required String district,
    required String bloodType,
  }) async {
    return await searchRepository.searchForDonors(
      state: state,
      district: district,
      bloodType: bloodType,
    );
  }
}
