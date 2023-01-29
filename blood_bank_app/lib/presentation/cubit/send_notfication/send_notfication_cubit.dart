import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'send_notfication_state.dart';

class SendNotficationCubit extends Cubit<SendNotficationState> {
  SendNotficationCubit() : super(SendNotficationInitial());
}
