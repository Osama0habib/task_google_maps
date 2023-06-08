import 'package:task_google_maps/task/domain/entities/marker.dart';

class MarkerModel extends MarkerEntity {
  const MarkerModel(
      {required super.taskId, required super.lat, required super.lng, required super.name});

  factory MarkerModel.fromJson(Map<String, dynamic> json) =>
      MarkerModel(taskId: json["TaskID"],
        lat: json["Lat"],
        lng: json["Longt"],
        name: json["Name"],);
}