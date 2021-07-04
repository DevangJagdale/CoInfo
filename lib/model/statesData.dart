import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project/model/districtData.dart';

class StatesData {
  List<dynamic> states;

  StatesData({this.states});

  factory StatesData.fromJson(Map<String, dynamic> json) => StatesData(
        states: json['states'],
      );

  StatesData data;
  Map<int, dynamic> statesData;

  Future getStateData(state, district) async {
    final response = await http.get(
      Uri.parse('https://cdn-api.co-vin.in/api/v2/admin/location/states'),
    );
    if (response.statusCode == 200) {
      data = StatesData.fromJson(jsonDecode(response.body));
      statesData = data.states.asMap();

      for (int i = 0; i < statesData.length; i++) {
        // print(statesData[i]);

        if (statesData[i]['state_name'].toLowerCase() == state.toLowerCase()) {
          print('true');
          return await DistrictData()
              .getdistrictData(statesData[i]['state_id'], district);
        }
      }
    }
  }
}
