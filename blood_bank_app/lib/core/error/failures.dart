import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OffLineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class WrongDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnknownFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class FirebaseUnknownFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InvalidEmailFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class WeekPasswordFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmailAlreadyRegisteredFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class FirebaseNullValueFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class DoesnotSaveData extends Failure {
  @override
  List<Object?> get props => [];
}
