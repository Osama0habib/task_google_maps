import 'package:equatable/equatable.dart';

class MarkerEntity extends Equatable {
  final String taskId;
  final String lat;
  final String lng;
  final String name;

  const MarkerEntity({
    required this.taskId,
    required this.lat,
    required this.lng,
    required this.name,
  });

  @override
  List<Object> get props => [
        taskId,
        lat,
        lng,
        name,
      ];
}
