class MasterDetailModel {
  List<Gender>? gender;
  List<Qualification>? qualification;
  List<Designations>? designations;
  List<Salarydtl>? salarydtl;

  MasterDetailModel(
      {this.gender, this.qualification, this.designations, this.salarydtl});

  MasterDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['gender'] != null) {
      gender = <Gender>[];
      json['gender'].forEach((v) {
        gender!.add(new Gender.fromJson(v));
      });
    }
    if (json['qualification'] != null) {
      qualification = <Qualification>[];
      json['qualification'].forEach((v) {
        qualification!.add(new Qualification.fromJson(v));
      });
    }
    if (json['designations'] != null) {
      designations = <Designations>[];
      json['designations'].forEach((v) {
        designations!.add(new Designations.fromJson(v));
      });
    }
    if (json['salarydtl'] != null) {
      salarydtl = <Salarydtl>[];
      json['salarydtl'].forEach((v) {
        salarydtl!.add(new Salarydtl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gender != null) {
      data['gender'] = this.gender!.map((v) => v.toJson()).toList();
    }
    if (this.qualification != null) {
      data['qualification'] =
          this.qualification!.map((v) => v.toJson()).toList();
    }
    if (this.designations != null) {
      data['designations'] = this.designations!.map((v) => v.toJson()).toList();
    }
    if (this.salarydtl != null) {
      data['salarydtl'] = this.salarydtl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gender {
  String? gender;

  Gender({this.gender});

  Gender.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    return data;
  }
}

class Qualification {
  String? qualifyId;
  String? qualification;

  Qualification({this.qualifyId, this.qualification});

  Qualification.fromJson(Map<String, dynamic> json) {
    qualifyId = json['qualify_id'];
    qualification = json['qualification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qualify_id'] = this.qualifyId;
    data['qualification'] = this.qualification;
    return data;
  }
}

class Designations {
  String? desgId;
  String? designation;

  Designations({this.desgId, this.designation});

  Designations.fromJson(Map<String, dynamic> json) {
    desgId = json['desg_id'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desg_id'] = this.desgId;
    data['designation'] = this.designation;
    return data;
  }
}

class Salarydtl {
  String? userRole;
  String? salaryType;
  String? salaryRange;

  Salarydtl({this.userRole, this.salaryType, this.salaryRange});

  Salarydtl.fromJson(Map<String, dynamic> json) {
    userRole = json['user_role'];
    salaryType = json['salary_type'];
    salaryRange = json['salary_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_role'] = this.userRole;
    data['salary_type'] = this.salaryType;
    data['salary_range'] = this.salaryRange;
    return data;
  }
}
