import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.usersID,
      required super.userName,
      required super.userPhone,
      required super.password,
      required super.email,
      required super.userToken,
      required super.userFirebaseToken,
      required super.loginType,
      required super.socialid,
      required super.userPhoto,
      required super.userStatus,
      required super.lastUpdatedUsers,
      required super.createdAtUser,
      required super.userRate,
      required super.userTimesOfRates,
      required super.userTotalRates,
      required super.tripNumber,
      required super.hasTrip,
      required super.login,
      required super.userVersion});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      usersID: json['UsersID'],
      userName: json['UserName'],
      userPhone: json['UserPhone'],
      password: json['Password'],
      email: json['Email'],
      userToken: json['UserToken'],
      userFirebaseToken: json['UserFirebaseToken'],
      loginType: json['LoginType'],
      socialid: json['Socialid'],
      userPhoto: json['UserPhoto'],
      userStatus: json['UserStatus'],
      lastUpdatedUsers: json['lastUpdatedUsers'],
      createdAtUser: json['CreatedAtUser'],
      userRate: json['UserRate'],
      userTimesOfRates: json['UserTimesOfRates'],
      userTotalRates: json['UserTotalRates'],
      tripNumber: json['TripNumber'],
      hasTrip: json['HasTrip'],
      login: json['Login'],
      userVersion: json['UserVersion']);
}
