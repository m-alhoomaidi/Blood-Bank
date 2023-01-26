// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/donor.dart';
import '../../domain/repositories/search_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final NetworkInfo networkInfo;
  SearchRepositoryImpl({
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Donor>>> searchForDonors({
    required String state,
    required String district,
    required String bloodType,
  }) async {
    if (await networkInfo.isConnected) {
      List<Donor> donors = <Donor>[];
      try {
        return await _fireStore
            .collection(DonorFields.collectionName)
            .where(DonorFields.state, isEqualTo: state)
            .where(DonorFields.district, isEqualTo: district)
            .get()
            .then((fetchedDonors) async {
          if (fetchedDonors.docs.isNotEmpty) {
            donors =
                fetchedDonors.docs.map((e) => Donor.fromMap(e.data())).toList();
            return Right(donors);
          } else {
            return const Right(<Donor>[]);
          }
        });
      } on FirebaseException catch (fireError) {
        print("Search====fireError.code");
        print(fireError.code);
        if (fireError.code == 'unknown') {
          return Left(FirebaseUnknownFailure());
        } else if (fireError.code == 'too-many-request') {
          return Left(ServerFailure());
        } else {
          return Left(UnknownFailure());
        }
      } catch (e) {
        print("Search====exception");
        print(e);
        return Left(UnknownFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
