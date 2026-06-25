class ScheduleModel {
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  ScheduleModel({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      dayOfWeek: json['dayOfWeek']?.toString() ?? json['DayOfWeek']?.toString() ?? '',
      startTime: json['startTime']?.toString() ?? json['StartTime']?.toString() ?? '',
      endTime: json['endTime']?.toString() ?? json['EndTime']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
