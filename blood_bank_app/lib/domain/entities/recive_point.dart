class RecivePoint {
  String latitude;
  String longitude;

  RecivePoint({required this.latitude, required this.longitude});

  factory RecivePoint.fromMap(Map<String, dynamic> json) {
    return RecivePoint(
        latitude: json['latitude'], longitude: json['longitude']);
  }
}
