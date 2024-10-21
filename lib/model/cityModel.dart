class CityModel {
  String? cityCode;
  String? cityName;
  String? stateCode;

  CityModel({this.cityCode, this.cityName, this.stateCode});

  CityModel.fromJson(Map<String, dynamic> json) {
    cityCode = json['city_code'];
    cityName = json['city_name'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_code'] = this.cityCode;
    data['city_name'] = this.cityName;
    data['state_code'] = this.stateCode;
    return data;
  }
}
