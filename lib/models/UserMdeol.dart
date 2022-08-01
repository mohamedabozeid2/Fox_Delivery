class FoxUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  int? packageNumber;
  int? completedPackages;
  int? notCompletedPackages;
  bool? isEmailVerified;

  FoxUserModel({
    required this.name,
    required this.uId,
    required this.email,
    required this.phone,
    required this.isEmailVerified,
    required this.completedPackages,
    required this.notCompletedPackages,
    required this.packageNumber
  });

  FoxUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    completedPackages = json['completedPackage'];
    notCompletedPackages = json['notCompletedPackages'];
    packageNumber = json['packageNumber'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'isEmailVerified' : isEmailVerified,
      'completedPackages' : completedPackages,
      'notCompletedPackages' : notCompletedPackages,
      'packageNumber' : packageNumber,
    };
  }
}
