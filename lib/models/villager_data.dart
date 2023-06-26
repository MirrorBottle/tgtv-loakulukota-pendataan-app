class VillagerListModel {
  int id;
  String idNumber;
  String name;

  VillagerListModel({ 
    required this.id,
    required this.idNumber,
    required this.name,
  });

  factory VillagerListModel.fromJson(Map<String, dynamic> _json) {
    return VillagerListModel(
      id: _json['id'],
      idNumber: _json['idNumber'],
      name: _json['name'],
    );
  }
}

class VillagerDetailModel {
  int id;
  int familyId;
  int neighborhoodId;
  String idNumber;
  String name;
  String birthPlace;
  String birthDate;
  String religion;
  String gender;
  String maritalStatus;
  String job;
  String fatherName;
  String motherName;
  String education;
  String? address;
  int isDeath;
  int isBirth;
  int isMoveIn;
  int isMoveOut;
  String? causeOfDeath;
  String? deathAt;
  String? bornAt;
  String? moveInAt;
  String? moveOutAt;
  String? createdAt;
  String? updatedAt;
  int age;
  String familyNumber;
  String neighborhoodName;

  VillagerDetailModel({ 
    required this.id,
    required this.familyId,
    required this.neighborhoodId,
    required this.idNumber,
    required this.name,
    required this.birthPlace,
    required this.birthDate,
    required this.religion,
    required this.gender,
    required this.maritalStatus,
    required this.job,
    required this.fatherName,
    required this.motherName,
    required this.education,
    this.address = "-",
    required this.isDeath,
    required this.isBirth,
    required this.isMoveIn,
    required this.isMoveOut,
    this.causeOfDeath = "-",
    this.deathAt = "-",
    this.bornAt = "-",
    this.moveInAt = "-",
    this.moveOutAt = "-",
    this.createdAt = "",
    this.updatedAt = "",
    required this.age,
    required this.familyNumber,
    required this.neighborhoodName
  });

  factory VillagerDetailModel.fromJson(Map<String, dynamic> _json) {
    return VillagerDetailModel(
      id: _json['id'],
      familyId: _json['familyId'],
      neighborhoodId: _json['neighborhoodId'],
      idNumber: _json['idNumber'],
      name: _json['name'],
      birthPlace: _json['birthPlace'],
      birthDate: _json['birthDate'],
      religion: _json['religion'],
      gender: _json['gender'],
      maritalStatus: _json['maritalStatus'],
      job: _json['job'],
      fatherName: _json['fatherName'],
      motherName: _json['motherName'],
      education: _json['education'],
      address: _json['address'],
      isDeath: _json['isDeath'],
      isBirth: _json['isBirth'],
      isMoveIn: _json['isMoveIn'],
      isMoveOut: _json['isMoveOut'],
      causeOfDeath: _json['causeOfDeath'],
      deathAt: _json['deathAt'],
      bornAt: _json['bornAt'],
      moveInAt: _json['moveInAt'],
      moveOutAt: _json['moveOutAt'],
      createdAt: _json['createdAt'],
      updatedAt: _json['updatedAt'],
      age: _json['age'],
      familyNumber: _json['familyNumber'],
      neighborhoodName: _json['neighborhoodName'],
    );
  }
}
