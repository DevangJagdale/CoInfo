import 'package:http/http.dart' as http;
import 'dart:convert';

class DistrictData {
  List<dynamic> district;

  DistrictData({this.district});

  factory DistrictData.fromJson(Map<String, dynamic> json) => DistrictData(
        district: json['districts'],
      );

  DistrictData data1;
  Map<int, dynamic> districtData;

  Future getdistrictData(districtId, districtName) async {
    final responseDistrict = await http.get(
      Uri.parse(
          'https://cdn-api.co-vin.in/api/v2/admin/location/districts/$districtId'),
    );
    // print(responseDistrict.body);
    if (responseDistrict.statusCode == 200) {
      data1 = DistrictData.fromJson(jsonDecode(responseDistrict.body));
      districtData = data1.district.asMap();
      // print(districtData);
      for (int i = 0; i < districtData.length; i++) {
        // print(statesData[i]);

        if (districtData[i]['district_name'].toLowerCase() ==
            districtName.toLowerCase()) {
          print('true');
          print(districtData[i]['district_name']);
          print(districtData[i]['district_id']);
          return districtData[i]['district_id'];
        }
      }
    }
  }
}
