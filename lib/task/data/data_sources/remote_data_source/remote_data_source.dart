
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task_google_maps/core/constants/api_constant.dart';

import '../../../../core/error/error_message_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../models/marker_model.dart';
import '../../models/user_model.dart';

abstract class BaseRemoteDataSource {
  Future<UserModel> signIn({required String userPhone ,required String password ,required String firebaseToken,});
  Future<List<MarkerModel>> getMarkers({required String token});
  Future<void> firebaseUpdateLocation({required String userId,required Position position});
  StreamSubscription<DatabaseEvent> firebaseGetMarkers({required String userId});
}


class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<UserModel> signIn({required String userPhone ,required String password ,required String firebaseToken,}) async {
    // {"Content-Type" : "multipart/form-data","Accept" : "*/*"}

    print(userPhone);
    print(password);

    var formData = FormData.fromMap({
      'UserPhone': userPhone ,
      'Password' : password,
      'UserFirebaseToken' : firebaseToken,
    });
       final response = await Dio().post(
          "https://engaztechnology.net/Himam/User/LoginUser.php",
          data: formData,
          options: Options(headers: {'Accept': '*/*',
            'Content-Type': 'multipart/form-data',},receiveDataWhenStatusError: true));

    if(response.statusCode == 200) {
      final r  = json.decode(response.data);
      print(r["data"]);
      return UserModel.fromJson((r["data"]));
    } else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MarkerModel>> getMarkers({required String token}) async {

    final response = await Dio().post(ApiConstant.markersUrl,options: Options(headers: {'Accept': '*/*',
      'Content-Type': 'application/json',"usertoken" : token},receiveDataWhenStatusError: true));

    if(response.statusCode == 200){
      final r  = json.decode(response.data);

      return List<MarkerModel>.from((r["data"] as List).map((e) => MarkerModel.fromJson(e)));
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<void> firebaseUpdateLocation({required String userId,required Position position}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("position/$userId");

    await ref.set({
      "lat": position.latitude,
      "lng": position.longitude,
      "heading": position.heading,
    });
  }

  @override
  StreamSubscription<DatabaseEvent> firebaseGetMarkers({required String userId}) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("position}");

    return ref.onValue.where((event) => event.snapshot.key != userId).listen((event) {

    });

  }

}