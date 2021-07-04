import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class VaccineData {
  List<dynamic> sessions;

  VaccineData({this.sessions});

  factory VaccineData.fromJson(Map<String, dynamic> json) => VaccineData(
        sessions: json['sessions'],
      );

  VaccineData data;
  Map<int, dynamic> vaccineData;
  var date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  Future getvaccineData(districtId) async {
    final response = await http.get(
      Uri.parse(
          'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=$districtId&date=$date'),
    );
    // print(responseDistrict.body);
    if (response.statusCode == 200) {
      data = VaccineData.fromJson(jsonDecode(response.body));
      vaccineData = data.sessions.asMap();
      print(date);
      print(vaccineData);
      return vaccineData;
    }
  }
}
