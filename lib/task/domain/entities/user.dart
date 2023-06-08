import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String usersID;
  final String userName;
  final String userPhone;
  final String password;
  final String email;
  final String userToken;
  final String userFirebaseToken;
  final String loginType;
  final String socialid;
  final String userPhoto;
  final String userStatus;
  final String lastUpdatedUsers;
  final String createdAtUser;
  final String userRate;
  final String userTimesOfRates;
  final String userTotalRates;
  final String tripNumber;
  final String hasTrip;
  final String login;
  final String userVersion;

  const User({
    required this.usersID,
    required this.userName,
    required this.userPhone,
    required this.password,
    required this.email,
    required this.userToken,
    required this.userFirebaseToken,
    required this.loginType,
    required this.socialid,
    required this.userPhoto,
    required this.userStatus,
    required this.lastUpdatedUsers,
    required this.createdAtUser,
    required this.userRate,
    required this.userTimesOfRates,
    required this.userTotalRates,
    required this.tripNumber,
    required this.hasTrip,
    required this.login,
    required this.userVersion
  });

  @override
  List<Object> get props =>
      [
        usersID,
        userName,
        userPhone,
        password,
        email,
        userToken,
        userFirebaseToken,
        loginType,
        socialid,
        userPhoto,
        userStatus,
        lastUpdatedUsers,
        createdAtUser,
        userRate,
        userTimesOfRates,
        userTotalRates,
        tripNumber,
        hasTrip,
        login,
        userVersion,
      ];
}
