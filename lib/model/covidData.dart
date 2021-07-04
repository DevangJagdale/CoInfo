class CovidResponse {
  List<dynamic> response;

  CovidResponse({this.response});

  factory CovidResponse.fromJson(Map<String, dynamic> json) => CovidResponse(
        response: json['response'],
      );
}
