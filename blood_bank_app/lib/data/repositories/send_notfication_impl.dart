import 'package:blood_bank_app/presentation/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/core/network/network_info.dart';
import 'package:blood_bank_app/domain/repositories/notfication_repository.dart';
import 'package:blood_bank_app/domain/usecases/send_notfication_.dart';
import 'package:http/http.dart' as http;

class SendNotficationImpl implements SendNotficationRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final NetworkInfo networkInfo;
  SendNotficationData sendNotficationData;
  SendNotficationImpl({
    required this.networkInfo,
    required this.sendNotficationData,
  });

  @override
  Future<Either<Failure, Unit>> senNotficationToGroup(
      {required SendNotficationData sendNotficationData}) {
    // TODO: implement senNotficationToGroup
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Failure, Unit>> senNotficationToGroup(
  //     {required SendNotficationData sendNotficationData}) async {
  //       throw ;
  // //   try {
  // //     String dataNotifications = '{'
  // //         '"operation": "create",'
  // //         '"notification_key_name": "appUser-testUser",'
  // //         '"registration_ids":["fwSGgXVlQ1-DkWdPvwC2vU:APA91bFcNOMGE2cl9c-BPfzUk4ksX-EIOSKEIixpAoO0k0XE7blcIRugk8xIl_ZQTM3KxbPuVCyajUSrMF-9uzrRkpA6K98M8-khrQKuk_YKLhqonSHcgi5bcJhQcqcSqQcOLbhQEMUr","f-wunReNSZyR8BAs3xgl4y:APA91bE_FxTEdtlzH5PfdEau6vPVIfA3Hk8Ykb--azdYgONq3ZaN9D9HUQBnsDR36NYD74qEgfhHF-W_3JrMEwO8z6GIQPwXifmGeGpX4Qreb1TYgWC2ypAP6YuLcJW3UVmodljWqVx_"],'
  // //         '"notification" : {'
  // //         '"title":"${sendNotficationData.title}",'
  // //         '"body":"${sendNotficationData.body}"'
  // //         ' }'
  // //         ' }';

  // //     var response = await http.post(
  // //       Uri.parse(Constants.BASE_URL),
  // //       headers: <String, String>{
  // //         'Content-Type': 'application/json',
  // //         'Authorization': 'key= ${Constants.KEY_SERVER}',
  // //         'project_id': "${Constants.SENDER_ID}"
  // //       },
  // //       body: dataNotifications,
  // //     );

  // //     print(response.body.toString());

  // //     // return true;
  // //   } catch (e) {}
  // }
}
