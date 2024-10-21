class StateModel {
  String? stateCode;
  String? stateName;

  StateModel({this.stateCode, this.stateName});

  StateModel.fromJson(Map<String, dynamic> json) {
    stateCode = json['state_code'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    return data;
  }
}
